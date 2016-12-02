class RankingController < ApplicationController
  layout 'review_site'
  before_action :ranking
  def ranking
    @ranking = Product.limit(5)
  end  
end
