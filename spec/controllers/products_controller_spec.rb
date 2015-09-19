require 'rails_helper'
require 'spec_helper'

describe ProductsController do
  describe "GET index" do
    it "sets @categories" do
      category1 = Fabricate(:category)
      category2 = Fabricate(:category)
      get :index
      expect(assigns(:categories)).to eq([category1,category2])
    end

    it "sets @pages" do
      category1 = Fabricate(:category)
      11.times {Fabricate(:product, category_id: category1.id)}
      get :index
      expect(assigns(:pages)).to eq(2)
    end

    it "sets @current_page_number" do
      get :index, page_number: "5"
      expect(assigns(:current_page_number)).to eq(5)
    end

    it "sets @products for the page" do
      11.times {Fabricate(:product)}
      get :index, page_number: "1", sort_by: "created_at"
      expect(assigns(:products)).to match_array(Product.limit(10))
    end
  end

  describe "GET search" do
    it "sets @term" do
      get :search, search_term: "lamborghini", page_number: "5"
      expect(assigns(:term)).to eq("lamborghini")
    end

    it "sets @current_page_number" do
      get :search, search_term: "lamborghini", page_number: "5"
      expect(assigns(:current_page_number)).to eq(5)
    end

    it "sets @results" do
      lamborghini = Fabricate(:product, title: "Lamborghini", description: "Supercar")
      ferrari = Fabricate(:product, title: "Ferrari", description: "Supercar")
      get :search, search_term: "lamborghini", page_number: "5"
      expect(assigns(:results)).to eq([lamborghini])
    end

    context "with valid results" do
      before do
        11.times do |index|
          Fabricate(:product, title: "a#{index}")
        end
        get :search, search_term: "a", page_number: "1"
      end

      it "sets @pages" do
        expect(assigns(:pages)).to eq(2)
      end

      it "sets @products for the page" do
        expect(assigns(:products)).to match_array(Product.limit(10))
      end
    end

    context "when @results = []" do
      before do
        get :search, search_term: "", page_number: "1"
      end

      it "sets @pages" do
        expect(assigns(:pages)).to eq(1)
      end

      it "sets @products for the page" do
        expect(assigns(:products)).to eq([])
      end
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
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      review1 = Fabricate(:review, product_id: product.id, user_id: alice.id)
      review2 = Fabricate(:review, product_id: product.id, user_id: bob.id)
      get :show, id: product.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "sets @review" do
      product = Fabricate(:product)
      get :show, id: product.id
      expect(assigns(:review)).to be_new_record
      expect(assigns(:review)).to be_instance_of(Review)
    end
  end
end
