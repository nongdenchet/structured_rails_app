module Completes
  class OwnerError < ValidateError
    def initialize
      super('User can not complete his/her own recipe')
    end

    def code
      'IS_OWNER'
    end
  end
end
