module Reviews
  class AlreadyExistedError < ValidateError
    def initialize
      super('You have already reviewed this recipe')
    end

    def code
      'ALREADY_REVIEW'
    end
  end
end
