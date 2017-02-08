class Operation
  include Support::Authen
  include Support::Policy
  include Support::Validate

  attr_accessor :user, :params, :headers, :request_obj

  def initialize(params, request, user = nil)
    @params = params
    @request_obj = request
    @headers = request.headers
    @user = user
  end

  def execute
    begin
      authenticate!
      process
    rescue ActiveRecord::RecordNotFound => _
      raise NotFound
    end
  end

  private
  class << self
    attr_accessor :require_authen

    def require_authen!
      self.require_authen = true
    end
  end

  def process
    raise NotImplementedError
  end
end
