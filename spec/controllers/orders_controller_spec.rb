require 'rails_helper'
require 'spec_helper'

describe OrdersController do
  describe "GET index" do
    it_behaves_like "require sign in" do
      let(:action) {get :index}
    end

    it "sets @orders" do
      alice = Fabricate(:user)
      product = Fabricate(:product)
      set_current_user(alice)
      order1 = Fabricate(:order)
      order2 = Fabricate(:order)
      get :index
      expect(assigns(:orders)).to eq([order1,order2])
    end
  end

  describe "POST create" do
    let(:alice) {Fabricate(:user)}
    before {set_current_user(alice)}

    it_behaves_like "require sign in" do
      let(:action) {post :create}
    end

    it "creates the order" do
      post :create
      expect(Order.count).to eq(1)
    end

    it "redirects to the orders path" do
      post :create
      expect(response).to redirect_to orders_path
    end
  end

  describe "GET show" do
    it_behaves_like "require sign in" do
      let(:action) {get :show, id: 1}
    end

    it "sets @order" do
      alice = Fabricate(:user)
      set_current_user(alice)
      order = Fabricate(:order)
      get :show, id: order.id
      expect(assigns(:order)).to eq(order)
    end
  end
end
