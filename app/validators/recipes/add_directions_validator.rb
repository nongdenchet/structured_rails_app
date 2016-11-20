module Recipes
  class AddDirectionsValidator < Validator
    attr_accessor :directions

    validates :directions, empty_array: true

    def self.require_params(params)
      params.permit(:directions)
    end
  end
end
