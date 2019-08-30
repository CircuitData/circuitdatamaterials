source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

gem "rails", "~> 5.2.3"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "rest-client"
gem "will_paginate", "~> 3.1.0"
gem "api-pagination"
gem "active_model_serializers", "~> 0.10.2"
gem "circuitdata", github: 'Elmatica/circuit-data-gem'
gem "active_record_upsert"
gem "bootstrap", "~> 4.3.1"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "bootsnap", ">= 1.1.0", require: false
gem "pagy"

group :development, :test do
  gem "byebug", platform: :mri
  gem "pry-rails"
  gem "pry-rescue"
end

group :development do
  gem "web-console", ">= 3.3.0"
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
