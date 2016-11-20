class Service
  include Support::Authen
  include Support::Policy

  attr_accessor :user, :params

  def initialize(params, user = nil)
    @params = params
    @user = user
  end

  def execute
    begin
      authenticate!
      process
    rescue ActiveRecord::RecordNotFound => _
      raise RecordNotFound
    end
  end

  private
  class << self
    attr_accessor :policy, :require_authen

    def with_policy(policy)
      self.policy = policy
    end

    def require_authen!
      self.require_authen = true
    end
  end

  def process
    raise NotImplementedError
  end
end
