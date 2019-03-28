source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby "2.6.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.2"
gem "pg"
gem "puma", "~> 3.0"
gem "bootsnap", require: false
gem "rest-client"
gem "will_paginate", "~> 3.1.0"
gem "api-pagination"
gem "active_model_serializers", "~> 0.10.2"
gem "rack-attack"

group :development, :test do
  gem "byebug", platform: :mri
  gem "pry-rails"
  gem "pry-rescue"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rspec_junit_formatter"
  gem "rspec-rails"
  gem "factory_bot_rails"
end
