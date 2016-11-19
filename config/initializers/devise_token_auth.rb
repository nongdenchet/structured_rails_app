DeviseTokenAuth.setup do |config|
  config.max_number_of_devices = 10
  config.change_headers_on_each_request = false
  config.token_lifespan = 2.year
  config.default_confirm_success_url = '/confirm'
end
