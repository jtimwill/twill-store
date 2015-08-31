shared_examples "require sign in" do
  it "redirects to the sign in page" do
    clear_current_user
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "require admin" do
  it "redirects to the home page" do
    session[:user_id] = Fabricate(:user).id
    action
    expect(response).to redirect_to root_path
  end
end
