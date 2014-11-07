source 'https://rubygems.org'

gem 'rails', '4.1.7'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

gem "nationbuilder-rb", require: "nationbuilder"
gem "twilio-ruby"
gem "pry-rails"
gem "rails_admin"

group :development do
  gem "guard", require: false
  gem "guard-bundler", require: false
  gem "guard-rspec", require: false
  gem "guard-rails", require: false
  gem "terminal-notifier-guard", require: false
end

group :test do
  gem "rspec-rails"
  gem "database_cleaner"
end

group :development, :test do
  gem "byebug", require: false
end
