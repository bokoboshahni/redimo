# frozen_string_literal: true

PROGRESS_BAR_FORMAT = '[:bar] :current/:total :percent ET::elapsed ETA::eta :rate/s'

namespace :eve do # rubocop:disable Metrics/BlockLength
  namespace :types do # rubocop:disable Metrics/BlockLength
    task download: :environment do # rubocop:disable Metrics/BlockLength
      require 'tty-progressbar'

      sde_types = YAML.load_file(Rails.root.join('db/sde/fsd/typeIDs.yaml'))
      esi_types = YAML.load_file(Rails.root.join('db/esi/types.yaml'))
      type_ids = sde_types.keys - esi_types.keys

      esi_base_url = Rails.application.config.x.esi.base_url
      user_agent = Rails.application.config.x.hos.user_agent
      progress = TTY::ProgressBar.new("Fetching EVE Types #{PROGRESS_BAR_FORMAT}", total: type_ids.count,
                                                                                   bar_format: :box)
      type_ids.each_slice(16) do |slice|
        workers = []
        workers << Thread.new do
          esi = Faraday.new do |f|
            f.use :http_cache, store: Rails.cache, logger: Rails.logger, instrumenter: ActiveSupport::Notifications
            f.request :url_encoded
            f.request :retry
            f.response :json
          end

          slice.each do |type_id|
            Retriable.retriable on: [Faraday::ParsingError, Faraday::ConnectionFailed, SocketError], tries: 10 do
              response = esi.get("#{esi_base_url}/v3/universe/types/#{type_id}",
                                 headers: { 'User-Agent' => user_agent })
              esi_types[type_id] = response.body
              progress.advance
            end
          end
        rescue ThreadError => e
          Rails.logger.error(e)
        end
        workers.each(&:join)
      end

      File.write(Rails.root.join('db/esi/types.yaml'), esi_types.to_yaml)
    end

    task verify: :environment do
      sde_types = YAML.load_file(Rails.root.join('db/sde/fsd/typeIDs.yaml'))
      esi_types = YAML.load_file(Rails.root.join('db/esi/types.yaml'))
      missing_type_ids = sde_types.keys - esi_types.keys

      puts "Missing #{missing_type_ids.count} type(s)" if missing_type_ids.any?
    end

    task load: :environment do # rubocop:disable Metrics/BlockLength
      require 'tty-progressbar'

      esi_types = YAML.load_file(Rails.root.join('db/esi/types.yaml'))

      type_ids = esi_types.keys
      progress = TTY::ProgressBar.new("Fetching EVE Types #{PROGRESS_BAR_FORMAT}", total: type_ids.count,
                                                                                   bar_format: :box)
      type_ids.each_slice(16) do |slice|
        workers = []
        workers << Thread.new do
          slice.each do |type_id|
            esi_type = esi_types[type_id]
            attribute_names = %i[
              capacity description dogma_attributes dogma_effects
              graphic_id group_id icon_id market_group_id mass name
              packaged_volume portion_size published radius volume
            ]
            attributes = attribute_names.index_with { |attr| esi_type[attr.to_s] }

            type = EVEType.find_by(type_id: type_id)
            if type
              type.update_columns(attributes) # rubocop:disable Rails/SkipsModelValidations
            else
              EVEType.create!(attributes.merge(type_id: type_id))
            end

            progress.advance
          end
        rescue ThreadError => e
          Rails.logger.error(e)
        end
        workers.each(&:join)
      end
    end
  end
end
