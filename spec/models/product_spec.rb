require 'rails_helper'
require 'spec_helper'

describe Product do
  it {should have_many(:orders)}
  it {should have_many(:users).through(:orders)}
  it {should have_many(:reviews)}
  it {should have_one(:cart_item)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}

  describe "#rating" do
    let(:product) {Fabricate(:product)}

    it "returns the average rating of a product to the nearest tenth" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      carl = Fabricate(:user)
      Fabricate(:review, user_id: alice.id, product_id: product.id, rating: 1)
      Fabricate(:review, user_id: bob.id, product_id: product.id, rating: 1)
      Fabricate(:review, user_id: carl.id, product_id: product.id, rating: 3)
      expect(product.rating).to eq(1.7)
    end

    it "returns nil when a rating is not present" do
      expect(product.rating).to be_nil
    end
  end
end
