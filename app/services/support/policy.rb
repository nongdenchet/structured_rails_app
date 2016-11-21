module Support
  module Policy
    def policy
      "#{self.class.to_s.split('::').first}Policy".constantize
    end

    def authorize!
      if self.class.require_authorize
        raise PermissionDenied unless policy.send(action, user)
      end
    end

    def authorize_record!(record)
      raise PermissionDenied unless policy.send(action_record, user, record)
    end

    def action
      self.class.to_s.underscore.split('/').last + '?'
    end

    def action_record
      self.class.to_s.underscore.split('/').last + '_record?'
    end
  end
end
