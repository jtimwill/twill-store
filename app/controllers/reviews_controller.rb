class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params.merge!(user: current_user))
    if @review.save
      @product.add_rating
      redirect_to @product
    else
      @reviews = @product.reviews.reload
      flash.now[:danger] = "Invalid review. Please check the errors below."
      render 'products/show'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    review = Review.find(params[:id])
    if current_user.reviews.include?(review)
      @product.remove_rating
      review.destroy
    end
    redirect_to user_path(current_user)
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
