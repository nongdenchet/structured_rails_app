module Completes
  class NotOwnerError < ValidateError
    def initialize
      super('User can not complete his/her own recipe')
    end

    def code
      'NOT_OWNER'
    end
  end
end
