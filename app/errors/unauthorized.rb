class Unauthorized < BaseError
  def initialize(error = 'Unauthorized')
    @error = error
  end

  def code
    'UNAUTHORIZED'
  end

  def status
    401
  end
end
