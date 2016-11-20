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
      class_name = StringUtils.underscore(self.class.to_s)
      class_name.split('/').last + '?'
    end

    def action_record
      class_name = StringUtils.underscore(self.class.to_s)
      class_name.split('/').last + '_record?'
    end
  end
end
