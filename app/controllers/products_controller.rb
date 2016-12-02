class ProductsController < RankingController
  def index
    # productsテーブルから最新順に作品を２０件取得する
    @products = Product.order('id ASC').limit(20)
  end

  def show
    # productsテーブルから該当するidの作品情報を取得し@productの変数へ代入する処理を書いて下さい
    @product = Product.find(params[:id]) # 問題3ではこのコードは消して新しくコードを書いてください
  end

  def search
    # 検索フォームのキーワードをあいまい検索して、productsテーブルから20件の作品情報を取得する
    @products = Product.where('title LIKE(?)',"%#{params[:keyword]}%").limit(20)
  end

  def configure_title

end
