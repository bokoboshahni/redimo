# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.timeout_in = 30.minutes

  config.omniauth :customer,
                  ENV['ESI_CUSTOMER_CLIENT_ID'],
                  ENV['ESI_CUSTOMER_CLIENT_SECRET'],
                  strategy_class: OmniAuth::Strategies::EveOnlineSso,
                  scope: Redimo::Application::ESI_CUSTOMER_SCOPES,
                  name: 'customer'

  config.omniauth :procurer,
                  ENV['ESI_PROCURER_CLIENT_ID'],
                  ENV['ESI_PROCURER_CLIENT_SECRET'],
                  strategy_class: OmniAuth::Strategies::EveOnlineSso,
                  scope: Redimo::Application::ESI_PROCURER_SCOPES,
                  name: 'procurer'
end
