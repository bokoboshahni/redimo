# frozen_string_literal: true

if Rails.env.production? || Rails.env.staging?
  Sentry.init do |config|
    config.dsn = ENV['SENTRY_DSN']
    config.breadcrumbs_logger = [:active_support_logger]

    config.traces_sample_rate = 0.5
    config.traces_sampler = lambda do |_context|
      true
    end
  end
end
