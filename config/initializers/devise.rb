# frozen_string_literal: true

Devise.setup do |config|
  require 'devise/orm/active_record'

  config.timeout_in = 30.minutes

  config.omniauth :customer,
                  Rails.application.config.x.esi.customer_client_id,
                  Rails.application.config.x.esi.customer_client_secret,
                  strategy_class: OmniAuth::Strategies::EveOnlineSso,
                  scope: Rails.application.config.x.esi.customer_scopes,
                  name: 'customer'

  config.omniauth :associate,
                  Rails.application.config.x.esi.associate_client_id,
                  Rails.application.config.x.esi.associate_client_secret,
                  strategy_class: OmniAuth::Strategies::EveOnlineSso,
                  scope: Rails.application.config.x.esi.associate_scopes,
                  name: 'associate'
end
