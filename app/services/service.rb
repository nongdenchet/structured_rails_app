class Service
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
      raise RecordNotFound
    end
  end

  def process
    raise 'This method must be implemented'
  end

  protected
  def policy
    nil
  end

  def require_authen?
    false
  end

  private
  def authenticate!
    if require_authen? && user == nil
      raise Unauthorized
    end
  end

  def authorize!
    if policy
      raise PermissionDenied unless policy.send(action, user)
    end
  end

  def authorize_record!(record)
    if policy
      raise PermissionDenied unless policy.send(action, user, record)
    end
  end

  def action
    StringUtils.underscore(self.class.to_s)
  end
end
