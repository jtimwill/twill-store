class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @pages = @category.products.number_of_pages
    @current_page_number = params[:page_number].to_i
    @products =  @category.products.order(params[:sort_by]).products_on_page(@current_page_number)
  end
end
