# frozen_string_literal: true

# Checks whether the current version of the SDE has already been archived.
class CheckSDE
  SDE_CHECKSUM_URL = 'https://eve-static-data-export.s3-eu-west-1.amazonaws.com/tranquility/checksum'

  RETRIABLE_ERRORS = [Faraday::ConnectionFailed, SocketError].freeze

  def initialize; end

  def call
    checksum = source_connection.get(SDE_CHECKSUM_URL).body.strip
  end

  private

  def source_connection
    @source_connection = Faraday.new do |f|
      f.use :http_cache, store: Rails.cache, logger: Rails.logger, instrumenter: ActiveSupport::Notifications
      f.request :url_encoded
      f.request :retry
      f.response :follow_redirects
    end
  end
end
