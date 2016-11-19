module Matchers
  module HasDefaultValue
    RSpec::Matchers.define :has_default_value do |attribute, value|
      match do |model|
        model.save validate: false
        expect(model.send(attribute)).to eq value
      end

      description do
        "has default value for #{attribute} is #{value}"
      end
    end
  end
end
