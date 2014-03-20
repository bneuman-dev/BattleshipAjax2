require 'rubygems'
require 'capybara/rspec'
require 'database_cleaner'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'
DatabaseCleaner[:active_record].strategy = :truncation
require File.expand_path("../../config/environment", __FILE__)
RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.before(:suite) do
    DatabaseCleaner.clean
  end

  config.before(:each) do |example|
    DatabaseCleaner.clean
  end
end