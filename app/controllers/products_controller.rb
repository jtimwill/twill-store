class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @pages = Product.number_of_pages
    @current_page_number = params[:page_number].to_i
    @products = Product.order(params[:sort_by]).products_on_page(@current_page_number)
  end

  def search
    @term = params[:search_term]
    @current_page_number = params[:page_number].to_i
    @results = Product.search_by_title(@term)

    if @results == []
      @pages = 1
      @products = @results
    else
      @pages = @results.number_of_pages
      @products = @results.products_on_page(@current_page_number)
    end
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @review = Review.new
  end
end
