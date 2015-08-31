require 'rails_helper'
require 'spec_helper'

describe CategoriesController do
  describe "GET show" do
    it_behaves_like "require sign in" do
      let(:action) {get :show, id: 3}
    end

    it "sets @category" do
      set_current_user
      category = Fabricate(:category)
      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end
end
