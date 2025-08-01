require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"
require "dotenv"

# Require the gems listed in Gemfile, including any gems
Bundler.require(*Rails.groups)

module ToDoApi
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

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # config.assets.enabled = false
    Dotenv.load(
      '.env',                             # Base defaults
      ".env.#{Rails.env}.local",          # Local overrides (ignored by git)
      ".env.#{Rails.env}",                # Environment-specific
      ".env.local"                        # Local developer overrides
    )
    
    # config.before_configuration do
    #   env_file = File.join(Rails.root, 'config', 'local_env.yml')
    #   YAML.load(File.open(env_file)).each do |key, value|
    #     ENV[key.to_s] = value.to_s
    #   end if File.exists?(env_file)
    # end

    # Rails.application.config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     origins ENV['ORIGIN']
    #     resource '*',
    #     headers: :any,
    #     methods: [:get, :patch, :delete, :post]
    #   end
    # end
  end
end
