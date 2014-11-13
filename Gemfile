source 'https://rubygems.org'
ruby "2.1.4"

gem 'rails', '4.1.7'
gem 'pg', group: :production
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'd3-rails'
gem 'devise'
gem 'font-awesome-rails'

gem "nationbuilder-rb", require: "nationbuilder"
gem "twilio-ruby"
gem "pry-rails"
gem "figaro"
gem "attribute_normalizer"
gem "jbuilder"
gem "liquid"

group :development do
  gem "guard", require: false
  gem "guard-bundler", require: false
  gem "guard-rspec", require: false
  gem "guard-rails", require: false
  gem "terminal-notifier-guard", require: false
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end

group :development, :test do
  gem "sqlite3"
  gem "rspec-rails"
  gem "database_cleaner"
  gem "byebug", require: false
  gem "faker"
  gem "factory_girl_rails"
end

group :production do
  gem "rails_12factor"
  gem "unicorn"
end
