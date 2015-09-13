require 'rails_helper'
require 'spec_helper'

describe OrdersController do
  describe "GET new" do
    let(:alice) {Fabricate(:user)}
    before {set_current_user(alice)}

    it_behaves_like "require sign in" do
      let(:action) {get :new}
    end

    it_behaves_like "require items" do
      let(:action) {get :new}
    end

    it "sets @free_shipping" do
      product = Fabricate(:product, price: 10000)
      cart_item = Fabricate(:cart_item, user_id: alice.id, product_id: product.id, quantity: 7)
      shipping_option = Fabricate(:shipping_option, title: 'Free Shipping (5-8 business days)')
      get :new
      expect(assigns(:free_shipping)).to eq(shipping_option)
    end

    it "sets @standard_shipping" do
      product = Fabricate(:product, price: 10000)
      cart_item = Fabricate(:cart_item, user_id: alice.id, product_id: product.id, quantity: 7)
      shipping_option = Fabricate(:shipping_option, title: 'Standard Shipping (4-5 business days)')
      get :new
      expect(assigns(:standard_shipping)).to eq(shipping_option)
    end

    it "sets @cart_items" do
      product1 = Fabricate(:product, price: 10000)
      product2 = Fabricate(:product, price: 5000)
      cart_item1 = Fabricate(:cart_item, user_id: alice.id, product_id: product1.id, quantity: 1)
      cart_item2 = Fabricate(:cart_item, user_id: alice.id, product_id: product2.id, quantity: 1)
      get :new
      expect(assigns(:cart_items)).to eq([cart_item1,cart_item2])
    end

    it "sets @order" do
      product = Fabricate(:product, price: 10000)
      Fabricate(:cart_item, user_id: alice.id, product_id: product.id, quantity: 7)
      get :new
      expect(assigns(:order)).to be_new_record
      expect(assigns(:order)).to be_instance_of(Order)
    end
  end

  describe "POST create" do
    let(:shipping_option) {Fabricate(:shipping_option, cost: 799)}
    let(:alice) {Fabricate(:user, username: "Alice", email: "alice@example.com")}
    before {set_current_user(alice)}
    before {ActionMailer::Base.deliveries.clear}

    it_behaves_like "require sign in" do
      let(:action) {post :create}
    end

    it_behaves_like "require items" do
      let(:action) {post :create}
    end

    # it "sets @order" do
    #   order = Fabricate(:order)
    #   product = Fabricate(:product, price: 10000)
    #   cart_item1 = Fabricate(:cart_item, user_id: alice.id, product_id: product.id, quantity: 1)
    #   post :create, optionsRadios: shipping_option.id
    #   expect(assigns(:order)).to be_instance_of(Order)
    #   expect(Order.last.total).to eq(10799)
    # end

    context "with valid input" do
      let(:charge) {double(:charge, successful?: true)}
      let(:product) {Fabricate(:product, price: 10000)}
      before{Fabricate(:cart_item, user_id: alice.id, product_id: product.id, quantity: 7)}
      before do
        expect(StripeWrapper::Charge).to receive(:create).and_return(charge)
      end

      it "creates an order" do
        post :create, optionsRadios: shipping_option.id
        expect(Order.count).to eq(1)
      end

      it "sends out an email" do
        post :create, optionsRadios: shipping_option.id
        expect(ActionMailer::Base.deliveries.last.to).to eq(["alice@example.com"])
      end

      it "sends out email containing the user's name and order total" do
        post :create, optionsRadios: shipping_option.id
        expect(ActionMailer::Base.deliveries.last.body).to include("Alice")
        expect(ActionMailer::Base.deliveries.last.body).to include("$707.99")
      end

      it "displays the success message" do
        post :create, optionsRadios: shipping_option.id
        expect(flash[:success]).to eq("Order Successful")
      end

      it "clears the user's cart" do
        post :create, optionsRadios: shipping_option.id
        expect(alice.cart_items.count).to eq(0)
      end

      it "redirects to the user profile" do
        post :create, optionsRadios: shipping_option.id
        expect(response).to redirect_to user_path(alice)
      end
    end

    context "declined card" do
      let(:charge) {double(:charge, successful?: false, error_message: "Your card was declined.")}
      let(:product) {Fabricate(:product, price: 10000)}
      before{Fabricate(:cart_item, user_id: alice.id, product_id: product.id, quantity: 7)}
      before do
        expect(StripeWrapper::Charge).to receive(:create).and_return(charge)
      end

      it "does not create a new order" do
        post :create, optionsRadios: shipping_option.id
        expect(Order.count).to eq(0)
      end

      it "does not send out email" do
        post :create, optionsRadios: shipping_option.id
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "displays the danger message" do
        post :create, optionsRadios: shipping_option.id
        expect(flash[:danger]).to be_present
      end

      it "renders the new template" do
        post :create, optionsRadios: shipping_option.id
        expect(response).to render_template "users/show"
      end
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
