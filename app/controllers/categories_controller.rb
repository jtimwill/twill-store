class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @products = @category.products.limit(Product::PER_PAGE).offset(params[:offset])
    @pages = (@category.products.all.size.to_f / Product::PER_PAGE).ceil

    if params[:offset].nil?
      @current_page = 1
    else
      @current_page = params[:offset].to_i/@products.count + 1
    end
  end
end
