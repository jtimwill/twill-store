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

  describe "GET omniauth" do
    context "successful authentication and new user" do
      before do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:test]
        get :omniauth, provider: "test"
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "puts the new signed in user in the session" do
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "sets the notice" do
        expect(flash[:info]).to eq('You are signed in')
      end

      it "redrects to home page" do
        expect(response).to redirect_to root_path
      end
    end

    context "successful authentication and existing user" do
      before do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:test]
      end

      it "does not create a new user" do
        Fabricate(:user, uid: '1234567', provider: 'test-provider', email: 'joe@bloggs.com', username: 'Joe Bloggs')
        get :omniauth, provider: "test"
        expect(User.count).to eq(1)
      end

      it "puts the new signed in user in the session" do
        get :omniauth, provider: "test"
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "sets the notice" do
        get :omniauth, provider: "test"
        expect(flash[:info]).to eq('You are signed in')
      end

      it "redrects to home page" do
        get :omniauth, provider: "test"
        expect(response).to redirect_to root_path
      end
    end

    context "failed authentication" do
      before do
        OmniAuth.config.mock_auth[:invalid] = :invalid_credentials
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:invalid]
        get :omniauth, provider: "invalid"
      end

      it "sets the error message" do
        expect(flash[:danger]).to eq('Authentication failure.')
      end

      it "redrects to the sign in page" do
        expect(response).to redirect_to login_path
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
