require 'rails_helper'
require 'spec_helper'

describe Admin::ProductsController do
  describe "GET new" do
    it_behaves_like "require sign in" do
      let(:action) {get :new}
    end

    it_behaves_like "require admin" do
      let(:action) {get :new}
    end

    it "sets @product to a new product" do
      set_current_admin
      get :new
      expect(assigns(:product)).to be_instance_of(Product)
      expect(assigns(:product)).to be_new_record
    end

    it "redirects the regular user to the home path" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end

    it "sets the flash error message for regular users" do
      set_current_user
      get :new
      expect(flash[:danger]).to be_present
    end
  end

  describe "POST create" do
    it_behaves_like "require sign in" do
      let(:action) {post :create}
    end

    it_behaves_like "require admin" do
      let(:action) {post :create}
    end

    context "with valid inputs" do
      before do
        set_current_admin
        post :create, product: {title: "Lambo", description: "Fast Car!"}
      end

      it "sets the flash success message" do
        expect(flash[:success]).to eq("You've added a new product called 'Lambo'")
      end

      it "redirects to the add new product page" do
        expect(response).to redirect_to new_admin_product_path
      end

      it "creates a product" do
        expect(Product.count).to eq(1)
      end
    end

    context "with invalid input" do
      before do
        set_current_admin
        post :create, product: {title: "Lambo!"}
      end

      it "does not create a new product" do
        expect(Product.count).to eq(0)
      end

      it "sets @product" do
        expect(assigns(:product)).to be_present
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).to eq("Product creation failed.")
      end
    end
  end

  describe "DELETE destory" do
    before {set_current_admin}

    it_behaves_like "require sign in" do
      let(:action) {delete :destroy, id: 1}
    end

    it_behaves_like "require admin" do
      let(:action) {delete :destroy, id: 1}
    end

    it "deletes the product" do
      product = Fabricate(:product)
      delete :destroy, id: product.id
      expect(Product.count).to eq(0)
    end

    it "redirects to the product show page" do
      product = Fabricate(:product)
      delete :destroy, id: product.id
      expect(response).to redirect_to products_path
    end
  end
end
