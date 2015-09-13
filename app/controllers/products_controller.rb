class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.limit(Product::PER_PAGE).offset(params[:offset])
    @pages = (Product.all.size.to_f / Product::PER_PAGE).ceil

    if params[:offset].nil?
      @current_page = 1
    else
      @current_page = params[:offset].to_i/@products.count + 1
    end
  end

  def search
    @term = params[:search_term]
    @categories = Category.all
    @results = Product.search_by_title(params[:search_term])
    if @results == []
      @products = @results
      @pages = 1
    else
      @products = @results.limit(Product::PER_PAGE).offset(params[:offset])
      @pages = (@results.all.size.to_f / Product::PER_PAGE).ceil
    end

    if params[:offset].nil?
      @current_page = 1
    else
      @current_page = params[:offset].to_i/@products.count + 1
    end
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
  end
end
