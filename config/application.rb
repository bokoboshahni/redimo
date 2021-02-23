# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
# require "active_job/railtie"
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Redimo
  # The Rails application.
  class Application < Rails::Application
    ESI_CUSTOMER_SCOPES = 'publicData'

    ESI_PROCURER_SCOPES = %w[
      publicData
      esi-mail.read_mail.v1
      esi-mail.send_mail.v1
      esi-wallet.read_character_wallet.v1
      esi-assets.read_assets.v1
      esi-markets.structure_markets.v1
      esi-markets.read_character_orders.v1
      esi-contracts.read_character_contracts.v1
    ].join(' ')

    USER_AGENT = 'Redimobot/1.0; (+https://github.com/bokoboshahni/redimo)'

    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
