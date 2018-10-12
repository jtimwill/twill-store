source 'https://rubygems.org'

gem 'rails', '5.1.4'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'turbolinks', '~> 5'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'bcrypt'
gem 'sidekiq'
gem 'unicorn'
gem 'sentry-raven', :git => "https://github.com/getsentry/raven-ruby.git"
gem 'stripe'
# gem 'figaro'
# gem 'draper'
gem 'stripe_event'
gem 'bootswatch-rails'
gem 'celluloid', '0.16.0'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails'
  gem 'fabrication'
  gem 'faker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
end

group :test do
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end

group :production, :staging do
  gem 'pg'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
