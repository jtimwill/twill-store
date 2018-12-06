source 'https://rubygems.org'
ruby '2.5.1'

gem 'rails', '5.1.6.1'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'turbolinks', '~> 5'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'bcrypt'
gem 'puma'
# gem 'sidekiq'
# gem 'unicorn'
# gem 'sentry-raven'
gem 'stripe'
gem 'figaro'
gem 'bootswatch-rails'
gem 'celluloid', '0.16.0'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'letter_opener_web'

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
  gem 'letter_opener'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'foreman'
end

group :test do
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
  gem 'database_cleaner'
end

group :production, :staging do
  gem 'pg', '0.20.0'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
