require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CoffeeReciept
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
      g.view_specs = false
      g.helper_specs = false
      g.javascripts = false
      g.stylesheets = false
      g.helper = false
      g.decorator = false
    end
  end
end
