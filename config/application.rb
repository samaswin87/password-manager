require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PasswordManager
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Use Zeitwerk autoloader (Rails 6.0+ default)
    config.autoloader = :zeitwerk

    # Keep custom autoload paths
    config.autoload_paths << "#{Rails.root}/lib"

    # Custom locale configuration
    config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.{rb,yml}"]
    config.i18n.default_locale = "en"

    # Active Job configuration
    config.active_job.queue_adapter = :sidekiq

    # JavaScript engine
    config.generators.javascript_engine = :js
  end
end
