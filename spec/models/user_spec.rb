require 'rails_helper'
require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:username)}
  it {should validate_uniqueness_of(:username)}
  it {should validate_presence_of(:email)}
  it {should validate_uniqueness_of(:email)}
  it {should have_many(:cart_items)}
  it {should have_many(:reviews)}
  it {should have_many(:orders)}
  it {should have_many(:products).through(:orders)}

  describe "#items_in_cart" do
    it "returns the total number of items in a user's cart" do
      product1 = Fabricate(:product)
      product2 = Fabricate(:product)
      user = Fabricate(:user)
      Fabricate(:cart_item, user: user, product: product1, quantity: 2)
      Fabricate(:cart_item, user: user, product: product2, quantity: 3)
      expect(user.items_in_cart).to eq(5)
    end
  end

  describe "#cart_total" do
    let(:user) {Fabricate(:user)}

    it "returns the total price of all the items in a user's cart" do
      product1 = Fabricate(:product, price: 999)
      product2 = Fabricate(:product, price: 1599)
      Fabricate(:cart_item, user: user, product: product1, quantity: 2)
      Fabricate(:cart_item, user: user, product: product2, quantity: 3)
      expect(user.cart_total).to eq(6795)
    end

    it "returns zero if the cart is empty" do
      expect(user.cart_total).to eq(0)
    end
  end
end
