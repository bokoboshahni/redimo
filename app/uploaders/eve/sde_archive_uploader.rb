# frozen_string_literal: true

class SDEArchiveUploader < Shrine
  plugin :default_storage, store: :sde_archive
  plugin :model, cache: false
  plugin :instrumentation
  plugin :remote_url, max_size: 150 * 1024 * 1024 # 150M
  plugin :restore_cached_data
  plugin :signature
end
