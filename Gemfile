source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '6.0.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'jbuilder'
gem 'devise_token_auth'
gem 'rack-cors', require: 'rack/cors'
gem 'dotenv-rails'
gem 'has_scope'
gem 'will_paginate'
gem 'rswag'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-performance'
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
    gem 'rspec'
    gem 'rspec-rails'
    gem 'rspec-retry'
    gem 'factory_bot_rails', '6.0.0'
    gem 'faker'
    gem 'shoulda-matchers'
    gem 'database_cleaner'
    gem 'rails-controller-testing'
    gem 'simplecov', require: false
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
