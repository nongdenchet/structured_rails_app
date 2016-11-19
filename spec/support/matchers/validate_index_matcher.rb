module Matchers
  module ValidateIndexMatcher
    RSpec::Matchers.define :has_index_of do |attribute|
      match do |model|
        ActiveRecord::Migration.index_exists?(model.class.table_name, attribute)
      end

      description do
        "has index of #{attribute}"
      end
    end
  end
end
