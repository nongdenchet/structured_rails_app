module Support
  module Policy
    def policy
      self.class.policy
    end

    def authorize!
      if policy
        raise PermissionDenied unless policy.send(action, user)
      end
    end

    def authorize_record!(record)
      if policy
        raise PermissionDenied unless policy.send(action_record, user, record)
      end
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
