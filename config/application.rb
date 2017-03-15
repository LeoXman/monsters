require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ro
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
      g.assets false
    end
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.factory_girl false
    end
    config.generators do |g|
      g.factory_girl dir: 'spec/factories'
    end
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies # Required for all session management
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
  end
end
