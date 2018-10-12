require 'rails_helper'
require 'spec_helper'

describe CategoriesController do
  describe "GET show" do
    let(:category1) {Fabricate(:category)}
    let(:category2) {Fabricate(:category)}
    before {11.times {Fabricate(:product, category_id: category1.id)}}

    it "sets @categories" do
      get :show, params: {id: category1.id}
      expect(assigns(:categories)).to eq([category1,category2])
    end

    it "sets @category" do
      get :show, params: {id: category1.id}
      expect(assigns(:category)).to eq(category1)
    end

    it "sets @pages" do
      get :show, params: {id: category1.id}
      expect(assigns(:pages)).to eq(2)
    end

    it "sets @current_page_number" do
      get :show, params: {id: category1.id, page_number: "5"}
      expect(assigns(:current_page_number)).to eq(5)
    end

    it "sets @products for the page" do
      get :show, params: {id: category1.id, page_number: "1", sort_by: "created_at"}
      expect(assigns(:products)).to match_array(Product.limit(10))
    end
  end
end
