require 'rails_helper'
require 'spec_helper'

describe CategoriesController do
  describe "GET show" do
    it_behaves_like "require sign in" do
      let(:action) {get :show, id: 3}
    end

    it "sets @products eq to the category param" do
      set_current_user
      category1 = Fabricate(:category)
      category2 = Fabricate(:category)

      product1 = Fabricate(:product, category_id: category1.id)
      product2 = Fabricate(:product, category_id: category1.id)
      product3 = Fabricate(:product, category_id: category2.id)

      get :show, id: category1.id
      expect(assigns(:products)).to eq([product1,product2])
    end
  end
end
