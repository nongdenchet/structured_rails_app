class ValidateError < BaseError
  def initialize(error = [])
    @error = error
  end

  def status
    422
  end

  def code
    'UNPROCESSABLE ENTITY'
  end
end
