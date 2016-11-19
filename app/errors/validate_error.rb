class ValidateError < StandardError
  attr_reader :errors

  def initialize(errors)
    @errors = errors
  end

  def to_json
    {errors: errors}
  end
end
