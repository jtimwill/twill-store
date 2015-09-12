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

    context "with new item" do
      let(:product) {Fabricate(:product)}
      before do
        post :create, product_id: product.id, quantity: 1, user_id: alice.id
      end

      it "creates the cart_item" do
        expect(alice.cart_items.count).to eq(1)
      end

      it "creates a cart item associated with the signed in user" do
        expect(CartItem.first.user).to eq(alice)
      end

      it "does not not increment the product quantity" do
        expect(CartItem.first.quantity).to eq(1)
      end

      it "redirects to the cart path" do
        expect(response).to redirect_to cart_path
      end
    end

    context "with existing item" do
      let(:product) {Fabricate(:product)}

      it "does not create a new cart item" do
        cart_item = Fabricate(:cart_item, product_id: product.id, quantity: 4, user_id: alice.id)
        post :create, product_id: product.id, quantity: 3, user_id: alice.id
        expect(alice.cart_items.count).to eq(1)
      end

      it "increments the product quantity" do
        cart_item = Fabricate(:cart_item, product_id: product.id, quantity: 4, user_id: alice.id)
        post :create, product_id: product.id, quantity: 3, user_id: alice.id
        expect(CartItem.first.quantity).to eq(7)
      end

      it "redirects to the cart path" do
        cart_item = Fabricate(:cart_item, product_id: product.id, quantity: 4, user_id: alice.id)
        post :create, product_id: product.id, quantity: 3, user_id: alice.id
        expect(response).to redirect_to cart_path
      end
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

    it "redirects to the cart path" do
      cart_item = Fabricate(:cart_item)
      delete :destroy, id: cart_item.id
      expect(response).to redirect_to cart_path
    end
  end

  describe "POST update_cart" do
    let(:alice) {Fabricate(:user)}
    let(:product) {Fabricate(:product)}
    let(:cart_item1) {Fabricate(:cart_item, user: alice, quantity: 5, product: product)}
    let(:cart_item2) {Fabricate(:cart_item, user: alice, quantity: 5, product: product)}
    before {set_current_user(alice)}

    it_behaves_like "require sign in" do
      let(:action) {post :update_cart, cart_items: [{id: 1, quantity: 5}]}
    end
    # 
    # it_behaves_like "require items" do
    #   let(:action) {post :update_cart, cart_items: [{id: 1, quantity: 5}]}
    # end

    it "updates the cart item quantity" do
      post :update_cart, cart_items: [{id: cart_item1.id, quantity: 6}, {id: cart_item2.id, quantity: 4}]
      expect(alice.cart_items.reload.first.quantity).to eq(6)
      expect(alice.cart_items.reload.last.quantity).to eq(4)
    end

    it "redirects to the my queue page" do
      post :update_cart, cart_items: [{id: cart_item1.id, quantity: 5}, {id: cart_item1.id, quantity: 5}]
      expect(response).to redirect_to cart_path
    end
  end
end
