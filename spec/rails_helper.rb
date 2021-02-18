# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

require 'vcr'
VCR.config do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
end

require 'timecop'

Dir[Rails.root.join('spec/support/helpers/**/*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

require 'capybara/rspec'
require 'capybara/rails'
Capybara.server = :puma

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
end
