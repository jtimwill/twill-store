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
    let(:user) {Fabricate(:user)}
    let(:product) {Fabricate(:product)}

    it "returns the average rating of a product to the nearest tenth" do
      2.times {Fabricate(:review, user: user, product: product, rating: 1)}
      Fabricate(:review, user: user, product: product, rating: 3)
      expect(product.rating).to eq(1.7)
    end

    it "returns nil when a rating is not present" do
      expect(product.rating).to be_nil
    end
  end
end
