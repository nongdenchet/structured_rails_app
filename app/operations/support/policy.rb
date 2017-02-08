module Support
  module Policy
    def policy
      "#{self.class.to_s.split('::').first}Policy".constantize
    end

    def authorize!(record, error = PermissionDenied)
      raise error unless policy.send(action, user, record)
    end

    def action
      self.class.to_s.underscore.split('/').last + '?'
    end
  end
end
