class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @product = Product.find(params[:product_id])
    review = @product.reviews.build(review_params.merge!(user: current_user))

    if review.save
      redirect_to @product
    else
      @reviews = @product.reviews.reload
      render 'products/show'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    review = Review.find(params[:id])
    review.destroy if current_user.reviews.include?(review)
    redirect_to @product
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
