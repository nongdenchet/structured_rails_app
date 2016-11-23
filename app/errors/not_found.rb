class NotFound < BaseError
  def initialize(error = 'Record not found')
    @error = error
  end

  def code
    'NOT_FOUND'
  end

  def status
    404
  end
end
