# frozen_string_literal: true

require 'tty-progressbar'

# Downloads types from ESI.
class DownloadESITypes
  include ESIHelpers

  PROGRESS_BAR_FORMAT = '[:bar] :current/:total :percent ET::elapsed ETA::eta :rate/s'

  RETRIABLE_ERRORS = [Faraday::ParsingError, Faraday::ConnectionFailed, SocketError].freeze

  MAX_TRIES_PER_REQUEST = 10

  WORKERS = 16

  def initialize(type_ids, _output_file)
    @type_ids = type_ids
  end

  def call # rubocop:disable Metrics/MethodLength
    type_ids.each_slice(WORKERS) do |slice|
      workers = []
      workers << Thread.new do
        slice.each do |type_id|
          Retriable.retriable on: RETRIABLE_ERRORS, tries: MAX_TRIES_PER_REQUEST do
            response = esi_anon_get("/latest/universe/types/#{type_id}")
            esi_types[type_id] = response.body
            progress.advance
          end
        end
      rescue ThreadError => e
        Rails.logger.error(e)
      end
      workers.each(&:join)
    end
  end

  private

  def progress
    @progress ||= TTY::ProgressBar.new("Fetching EVE Types #{PROGRESS_BAR_FORMAT}", total: type_ids.count,
                                                                                    bar_format: :box)
  end

  def write_types(_file, _types)
    File.write(output_file, esi_types.to_yaml)
  end
end
