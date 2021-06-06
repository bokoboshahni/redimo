# Downloads the EVE static data export and commits the results to a Git repository.
class DownloadSDE
  SDE_REGION = 'eu-west-1'
  SDE_BUCKET = 'eve-static-data-export'
  SDE_ZIP_PATH = '/tranquility/sde.zip'
  SDE_CHECKSUM_PATH = '/tranquility/checksum'

  attr_reader :dir

  def initialize(dir)
    @dir = dir
  end

  def call
    checksum_file = File.join(dir, 'checksum.txt')
    s3.get_object(bucket: SDE_BUCKET, key: SDE_CHECKSUM_PATH, response_target: checksum_file)

    zip_file = File.join(dir, 'sde.zip')
    s3.get_object(bucket: SDE_BUCKET, key: SDE_ZIP_PATH, response_target: zip_file)
  end

  private

  def s3
    @s3 ||= Aws::S3::Client.new(region: SDE_REGION, credentials: Aws::SharedCredentials.new)
  end
end
