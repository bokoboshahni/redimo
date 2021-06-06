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

module HOS
  # The Rails application.
  class Application < Rails::Application
    config.x.esi.customer_client_id = ENV['ESI_CUSTOMER_CLIENT_ID']
    config.x.esi.customer_client_secret = ENV['ESI_CUSTOMER_CLIENT_SECRET']
    config.x.esi.customer_scopes = 'publicData'

    config.x.esi.associate_client_id = ENV['ESI_ASSOCIATE_CLIENT_ID']
    config.x.esi.associate_client_secret = ENV['ESI_ASSOCIATE_CLIENT_SECRET']
    config.x.esi.associate_scopes = %w[
      publicData
      esi-mail.read_mail.v1
      esi-mail.send_mail.v1
      esi-wallet.read_character_wallet.v1
      esi-assets.read_assets.v1
      esi-markets.structure_markets.v1
      esi-markets.read_character_orders.v1
      esi-contracts.read_character_contracts.v1
    ].join(' ')

    config.x.esi.base_url = 'https://esi.evetech.net'

    config.x.github.token = ENV['GITHUB_TOKEN']

    config.x.janice.api_key = ENV['JANICE_API_KEY']

    config.x.hos.user_agent = 'House of Suns/1.0; (+https://github.com/bokoboshahni/hos)'

    config.x.hos.allowed_alliance_ids = ENV.fetch('ALLOWED_ALLIANCE_IDS', '').strip.split(',').map(&:to_i)
    config.x.hos.allowed_corporation_ids = ENV.fetch('ALLOWED_CORPORATION_IDS', '').strip.split(',').map(&:to_i)

    config.x.data_bucket_access_key_id = ENV['DATA_BUCKET_ACCESS_KEY_ID']
    config.x.data_bucket_endpoint = ENV['DATA_BUCKET_ENDPOINT']
    config.x.data_bucket_name = ENV['DATA_BUCKET_NAME']
    config.x.data_bucket_secret_access_key = ENV['DATA_BUCKET_SECRET_ACCESS_KEY']

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
