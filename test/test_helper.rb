# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

PRIVATE_KEY = "fd93e783e4e1cac28c749fb247c12e40"

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

LodgeWebhook.config do |config|
  config[:webhook_secret] = PRIVATE_KEY
  config[:webhook_url] = 'http://localhost:3000/'
end


require 'mocha/test_unit'
require 'sender_mock'
