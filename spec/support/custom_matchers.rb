require 'rspec/expectations'
Dir[Rails.root.join('spec/support/matchers/*.rb')].each { |f| require f }

module CustomMatchers
  include Matchers::ValidateIndexMatcher
  include Matchers::ValidateEmailFormatMatcher
  include Matchers::HasDefaultValue
end
