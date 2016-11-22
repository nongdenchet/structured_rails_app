module Support
  module Validate
    def validator
      validator_class.constantize
    end

    def validator_class
      class_names = self.class.to_s.split('::')
      "#{class_names.second}::#{class_names.last}Validator"
    end

    def validate!(_params = params)
      validator.init(_params).validate!
    end
  end
end
