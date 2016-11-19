ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!
ActiveSupport::Deprecation.silenced = true

RSpec.configure do |config|
  config.include CustomMatcher, type: :model
  config.include CustomHelper, type: :controller
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
end