class CategoriesController < ApplicationController
  before_action :require_user

  def show
    category = Category.find(params[:id])
    @products = category.products
    respond_to do |format|
      format.html
      format.js
    end
  end
end
