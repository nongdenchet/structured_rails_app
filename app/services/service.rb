class Service
  include Support::Authen
  include Support::Policy
  include Support::Validate

  attr_accessor :user, :params

  def initialize(params, user = nil)
    @params = params
    @user = user
  end

  def execute
    begin
      authenticate!
      authorize!
      process
    rescue ActiveRecord::RecordNotFound => _
      raise NotFound
    end
  end

  private
  class << self
    attr_accessor :require_authorize, :require_authen

    def require_authorize!
      self.require_authorize = true
    end

    def require_authen!
      self.require_authen = true
    end
  end

  def process
    raise NotImplementedError
  end
end
