# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'sidekiq/testing/inline'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

OmniAuth.config.test_mode = true

valid_auth_hash = OmniAuth::AuthHash.new({
  :provider => 'test-provider',
  :uid => '1234567',
  :info => {
   :email => 'joe@bloggs.com',
   :name => 'Joe Bloggs'
  }
})

OmniAuth.config.add_mock(:valid, valid_auth_hash)

invalid_auth_hash = OmniAuth::AuthHash.new({
  :provider => nil,
  :uid => nil,
  :info => {
   :email => nil,
   :name => nil
  }
})

OmniAuth.config.add_mock(:invalid, invalid_auth_hash)
