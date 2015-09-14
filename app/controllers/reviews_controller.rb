class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @product = Product.find(params[:product_id])
    review = @product.reviews.build(review_params.merge!(user: current_user))
    if review.save
      add_rating(@product)
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
      remove_rating(@product)
      review.destroy
    end
    redirect_to user_path(current_user)
  end

  private

  def add_rating(product)
    total_reviews = product.reviews.count
    new_rating = ((total_reviews-1)*product.rating + product.reviews.last.rating)/total_reviews
    product.update_attributes(rating: new_rating)
  end

  def remove_rating(product)
    total_reviews = product.reviews.count
    new_rating = (total_reviews*product.rating - product.reviews.last.rating)/(total_reviews - 1)
    product.update_attributes(rating: new_rating)
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
