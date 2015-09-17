require 'rails_helper'
require 'spec_helper'

describe Product do
  it {should have_many(:orders)}
  it {should have_many(:users).through(:orders)}
  it {should have_many(:reviews)}
  it {should have_one(:cart_item)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}

  describe "products_on_page" do
    it "returns the first 10 products for the first page" do
      11.times {Fabricate(:product)}
      page_number = 1
      expect(Product.products_on_page(page_number)).to match_array(Product.limit(10))
    end

    it "returns the 11th product for the second page" do
      11.times {Fabricate(:product)}
      page_number = 2
      expect(Product.products_on_page(page_number)).to match_array(Product.last)
    end

    it "returns an empty array if there are no products" do
      11.times {Fabricate(:product)}
      page_number = 3
      expect(Product.products_on_page(page_number)).to match_array([])
    end
  end

  describe "number_of_pages" do
    it "returns 1 if the number of products is less than 11" do
      10.times {Fabricate(:product)}
      expect(Product.number_of_pages).to eq(1)
    end

    it "returns 2 if the number of products is greater than 10 and less than 21" do
      11.times {Fabricate(:product)}
      expect(Product.number_of_pages).to eq(2)
    end
  end

  describe "search_by_title" do
    let(:lamborghini) {Fabricate(:product, title: "Lamborghini", description: "Supercar", price: 100)}
    let(:ferrari) {Fabricate(:product, title: "Ferrari", description: "Supercar", price: 200)}

    it "returns empty array for search with empty string" do
      expect(Product.search_by_title("")).to eq([])
    end

    it "returns empty array if no match" do
      expect(Product.search_by_title("hello")).to eq([])
    end

    it "returns array of one product for exact match" do
      expect(Product.search_by_title("Lamborghini")).to eq([lamborghini])
    end

    it "returns array of one product for match with different case" do
      expect(Product.search_by_title("lamborghini")).to eq([lamborghini])
    end

    it "returns array of one product for partial match" do
      expect(Product.search_by_title("gh")).to eq([lamborghini])
    end

    it "returns array of all matches ordered by created_at" do
      expect(Product.search_by_title("a")).to eq([ferrari, lamborghini])
    end
  end

  describe "#show_rating" do
    it "returns the average rating of a product as a string" do
      product = Fabricate(:product, rating: 1.70)
      expect(product.show_rating).to eq("1.7/5")
    end

    it "returns a string when a rating is not present" do
      product = Fabricate(:product)
      expect(product.show_rating).to eq("no rating")
    end
  end

  describe "#add_rating" do
    it "updates the rating column of a product with no ratings" do
      alice = Fabricate(:user)
      product = Fabricate(:product)
      Fabricate(:review, user_id: alice.id, product_id: product.id, rating: 4)
      product.add_rating
      expect(product.rating).to eq(4.00)
    end
    it "updates the rating column of a product with existing ratings" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      carl = Fabricate(:user)
      product = Fabricate(:product, rating: 3.5)
      Fabricate(:review, user_id: alice.id, product_id: product.id)
      Fabricate(:review, user_id: bob.id, product_id: product.id)
      Fabricate(:review, user_id: carl.id, product_id: product.id, rating: 3)
      product.add_rating
      expect(product.rating).to eq(3.33)
    end
  end

  describe "#remove_rating" do
    it "updates the rating column of a product with one rating" do
      alice = Fabricate(:user)
      product = Fabricate(:product)
      Fabricate(:review, user_id: alice.id, product_id: product.id, rating: 4)
      product.remove_rating
      expect(product.rating).to be_nil
    end

    it "updates the rating column of a product with multiple ratings" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      carl = Fabricate(:user)
      product = Fabricate(:product, rating: 3.5)
      Fabricate(:review, user_id: alice.id, product_id: product.id)
      Fabricate(:review, user_id: bob.id, product_id: product.id)
      Fabricate(:review, user_id: carl.id, product_id: product.id, rating: 3)
      product.remove_rating
      expect(product.rating).to eq(3.75)
    end
  end
end
