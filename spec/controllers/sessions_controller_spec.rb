require 'rails_helper'
require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    context "with valid credentials" do
      before do
        alice = Fabricate(:user)
        post :create, username: alice.username, password: alice.password
      end

      it "puts the signed in user in the session" do
        alice = Fabricate(:user)
        post :create, username: alice.username, password: alice.password
        expect(session[:user_id]).to eq(alice.id)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to root_path
      end

      it "sets the notice" do
        expect(flash[:info]).to eq('You are signed in')
      end
    end

    context "with invalid credentials" do
      before do
        alice = Fabricate(:user)
        post :create, username: alice.username, password: alice.password + 'asdfasf'
      end

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "redrects to the sign in page" do
        expect(response).to redirect_to login_path
      end

      it "sets the error message" do
        expect(flash[:danger]).to eq('Invalid email or password')
      end
    end
  end

  describe "DELETE destroy" do
    before do
      set_current_user
      delete :destroy
    end

    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end

    it "sets the notice" do
      expect(flash[:info]).to eq('You are signed out.')
    end
  end
end
