class Service
  attr_accessor :user, :params

  def initialize(params, user = nil)
    @params = params
    @user = user
  end

  def execute
    begin
      serializer.new(process)
    rescue ActiveRecord::RecordNotFound => _
      raise RecordNotFound
    end
  end

  def process
    raise 'This method must be implemented'
  end

  protected
  def serializer
    raise 'This method must be implemented'
  end

  def policy
    raise 'This method must be implemented'
  end

  private
  def authenticated?
    user != nil
  end

  def authorize?
    policy.send(action, user)
  end

  def authorize_record?(record)
    policy.send(action, user, record)
  end

  def action
    StringUtils.underscore(self.class.to_s)
  end
end
