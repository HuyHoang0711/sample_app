require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.load_path += Dir[Rails.root.join("config", "locale", "**", "*.{rb,yml}").to_s]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi
  end
end


