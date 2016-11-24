 class Scraping
  def self.movie_urls
    agent = Mechanize.new
    links = []
    # パスの部分を変数で定義(はじめは、空にしておきます)
    next_url = ""

    while true do

      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      elements = current_page.search(".entry-title a")
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      # 「次へ」を表すタグを取得
      next_link = current_page.at('.pagination .next a')

      # next_linkがなかったらwhile文を抜ける
      unless next_link
        break
      end

      # そのタグからhref属性の値を取得
      next_url = next_link.get_attribute('href')
    end

    links.each do |link|
      get_product('http://review-movie.herokuapp.com' + link)
    end
  end

  def self.get_product(link)
    #⑦Mechanizeクラスのインスタンスを生成する
    agent = Mechanize.new
    #⑧映画の個別ページのURLを取得
    current_page = agent.get(link)
    #⑨inner_textメソッドを利用し映画のタイトルを取得
    title = current_page.at('.entry-title').inner_text
    #①⓪image_urlがあるsrc要素のみを取り出す
    image_url = current_page.at('.entry-content img').get_attribute('src')
    #①①newメソッド、saveメソッドを使い、 スクレイピングした「映画タイトル」と「作品画像のURL」をproductsテーブルに保存
    product = Product.where(title: title, image_url: image_url).first_or_initialize

    if current_page.at('.director span')
      director = current_page.at('.director span').inner_text
      product[:director] = director
    end

    if current_page.at('.entry-content p')
      detail = current_page.at('.entry-content p').inner_text
      product[:detail] = detail
    end

    if current_page.at('.date span')
      open_date = current_page.at('.date span').inner_text
      product[:open_date] = open_date
    end

    product.save
  end
end



