class ReviewsController < RankingController
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    # binding.pry
    Review.create(create_params)
    redirect_to controller: :products, action: :index
  end

  private
  def create_params
    params.require(:review).permit(:nickname, :rate, :review).merge(product_id: params[:product_id])
  end

end