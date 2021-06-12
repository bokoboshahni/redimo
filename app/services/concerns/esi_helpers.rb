# frozen_string_literal: true

# Helper methods for making API calls to ESI.
module ESIHelpers
  extend ActiveSupport::Concern

  def esi_anon_connection
    @esi_anon_connection = Faraday.new do |f|
      f.use :http_cache, store: Rails.cache, logger: Rails.logger, instrumenter: ActiveSupport::Notifications
      f.request :url_encoded
      f.request :retry
      f.response :follow_redirects
      f.response :json
    end
  end

  def esi_anon_get(path, params = {}, headers = {})
    response = esi_anon_connection.get("#{esi_config.base_url}#{path}") do |req|
      req.headers = headers.merge(esi_default_headers)
      req.params = params
    end
    response.body
  end

  def esi_base_url
    esi_config.base_url
  end

  def esi_default_headers
    {
      'User-Agent': Rails.application.config.x.hos.user_agent
    }
  end

  def esi_config
    Rails.application.config.x.esi
  end
end
