require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Surveyor
  class Application < Rails::Application
    config.generators.stylesheets = false
    config.generators.javascripts = false

    config.generators do |g|
      g.factory_girl = false
      g.stylesheets = false
      g.javascripts = false
    end

    config.to_prepare do
      Devise::SessionsController.layout "authentication" 
    end
  end
end
