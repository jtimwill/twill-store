require 'rails_helper'
require 'spec_helper'

describe ProductsController do
  describe "GET index" do
    it "sets @products" do
      product1 = Fabricate(:product)
      product2 = Fabricate(:product)
      get :index
      expect(assigns(:products)).to eq([product1,product2])
    end
  end

  describe "GET show" do
    it "sets @product" do
      product = Fabricate(:product)
      get :show, id: product.id
      expect(assigns(:product)).to eq(product)
    end

    it "sets @reviews" do
      product = Fabricate(:product)
      review1 = Fabricate(:review, product_id: product.id)
      review2 = Fabricate(:review, product_id: product.id)
      get :show, id: product.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
  end
end
