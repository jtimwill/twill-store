require 'rails_helper'
require 'spec_helper'

describe PagesController do
  describe "GET front" do
    before do
      get :front
    end

    it "renders the :front template" do
      expect(response).to render_template :front
    end
  end

  describe "GET faq" do
    before do
      get :faq
    end

    it "renders the :faq template" do
      expect(response).to render_template :faq
    end

    it "displays warning message" do
      expect(flash[:warning]).to be_truthy
    end
  end
end
