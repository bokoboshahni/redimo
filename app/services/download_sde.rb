# frozen_string_literal: true

# Downloads the current EVE static data export and checksum.
class DownloadSDE
  SDE_ZIP_URL = 'https://eve-static-data-export.s3-eu-west-1.amazonaws.com/tranquility/sde.zip'
  SDE_CHECKSUM_URL = 'https://eve-static-data-export.s3-eu-west-1.amazonaws.com/tranquility/checksum'

  attr_reader :dir

  def initialize(dir)
    @dir = dir
  end

  def call
    Down.download(SDE_CHECKSUM_URL, destination: File.join(dir, 'sde-checksum.txt'))
    Down.download(SDE_ZIP_URL, destination: File.join(dir, 'sde.zip'))
  end
end
