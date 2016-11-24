module Reviews
  class OwnerError < ValidateError
    def initialize
      super('User can not review his/her own recipe')
    end

    def code
      'IS_OWNER'
    end
  end
end
