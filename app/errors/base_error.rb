class BaseError < StandardError
  attr_reader :error

  def code
    raise 'This method must be implemented'
  end

  def status
    raise 'This method must be implemented'
  end

  def to_json
    {error: {message: error, code: code, status: status}}
  end
end
