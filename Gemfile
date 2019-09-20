source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

gem "rails", "~> 6.0"
gem "pg"
gem "puma"
gem "sass-rails"
gem "uglifier"
gem "rest-client"
gem "will_paginate"
gem "api-pagination"
gem "active_model_serializers", "~> 0.10.2"
gem "circuitdata", github: 'Elmatica/circuit-data-gem'
gem "active_record_upsert"
gem "bootstrap"
gem "jquery-rails"
gem "turbolinks"
gem "bootsnap", require: false
gem "pagy"

group :development, :test do
  gem "byebug", platform: :mri
  gem "pry-rails"
  gem "pry-rescue"
end

group :development do
  gem "web-console"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rspec_junit_formatter"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "capybara"
end
