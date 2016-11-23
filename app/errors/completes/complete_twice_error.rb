module Completes
  class CompleteTwiceError < ValidateError
    def initialize
      super('You have already completed this recipe')
    end

    def code
      'ALREADY_COMPLETE'
    end
  end
end
