require 'rails_helper'
require 'spec_helper'

describe CartItemsController do
  describe "GET index" do
    it_behaves_like "require sign in" do
      let(:action) {get :index}
    end

    it "sets @cart_items" do
      alice = Fabricate(:user)
      set_current_user(alice)
      cart_item1 = Fabricate(:cart_item)
      cart_item2 = Fabricate(:cart_item)
      get :index
      expect(assigns(:cart_items)).to eq([cart_item1,cart_item2])
    end
  end

  describe "POST create" do
    let(:alice) {Fabricate(:user)}
    before {set_current_user(alice)}

    it_behaves_like "require sign in" do
      let(:action) {post :create}
    end

    it "creates the cart_item" do
      post :create
      expect(CartItem.count).to eq(1)
    end

    it "redirects to the cart items path" do
      post :create
      expect(response).to redirect_to cart_items_path
    end
  end

  describe "DELETE destory" do
    let(:alice) {Fabricate(:user)}
    let(:bob) {Fabricate(:user)}
    before {set_current_user(alice)}

    it_behaves_like "require sign in" do
      let(:action) {delete :destroy, id: 1}
    end

    it "deletes the current user's cart_item" do
      cart_item = Fabricate(:cart_item, user_id: alice.id)
      delete :destroy, id: cart_item.id
      expect(CartItem.count).to eq(0)
    end

    it "does not delete the cart_item of a different user" do
      cart_item = Fabricate(:cart_item, user_id: bob.id)
      delete :destroy, id: cart_item.id
      expect(CartItem.count).to eq(1)
    end

    it "redirects to the cart item index page" do
      cart_item = Fabricate(:cart_item)
      delete :destroy, id: cart_item.id
      expect(response).to redirect_to cart_items_path
    end
  end
end
