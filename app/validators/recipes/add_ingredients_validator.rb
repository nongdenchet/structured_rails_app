module Recipes
  class AddIngredientsValidator < Validator
    attr_accessor :ingredients

    validates :ingredients, empty_array: true

    def self.require_params(params)
      params.permit!
      params.slice(:ingredients)
    end
  end
end
