# frozen_string_literal: true

require 'shrine/storage/s3'

sde_archive_storage = Shrine::Storage::S3.new(
  endpoint: Rails.application.config.x.sde.archive.endpoint,
  bucket: Rails.application.config.x.sde.archive.bucket,
  region: Rails.application.config.x.sde.archive.region,
  access_key_id: Rails.application.config.x.sde.archive.access_key_id,
  secret_access_key: Rails.application.config.x.sde.archive.secret_access_key,
  retry_mode: 'standard'
)

Shrine.storages = {
  sde_archive: sde_archive_storage
}
