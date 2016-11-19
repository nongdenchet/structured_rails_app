module Support
  module Authen
    def require_authen
      self.class.require_authen ||= false
    end

    def authenticate!
      if require_authen && user == nil
        raise Unauthorized
      end
    end
  end
end
