Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  {
    :scope => "public_profile",
    :info_fields=> "name,email"
  }

  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
    {
      :name => "google",
      :scope => "email, profile"
    }
end
