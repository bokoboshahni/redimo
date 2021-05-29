# frozen_string_literal: true

Devise.setup do |config|
  require 'devise/orm/active_record'

  config.timeout_in = 30.minutes

  config.omniauth :customer,
                  ENV['ESI_CUSTOMER_CLIENT_ID'],
                  ENV['ESI_CUSTOMER_CLIENT_SECRET'],
                  strategy_class: OmniAuth::Strategies::EveOnlineSso,
                  scope: HOS::Application::ESI_CUSTOMER_SCOPES,
                  name: 'customer'

  config.omniauth :associate,
                  ENV['ESI_ASSOCIATE_CLIENT_ID'],
                  ENV['ESI_ASSOCIATE_CLIENT_SECRET'],
                  strategy_class: OmniAuth::Strategies::EveOnlineSso,
                  scope: HOS::Application::ESI_ASSOCIATE_SCOPES,
                  name: 'associate'
end
