module Support
  module Validate
    def validator
      "#{self.class.to_s}Validator".constantize
    end

    def validate!(_params = params)
      validator.init(_params).validate!
    end
  end
end
