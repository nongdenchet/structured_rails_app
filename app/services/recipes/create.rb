module Recipes
  class Create < Service
    def process
      validate!
      recipe = user.recipes.create!(recipe_params)
      Recipes::ShortSerializer.new(recipe)
    end

    private
    def require_authen?
      true
    end

    def validate!
      RecipeValidator.new(recipe_params).validate!
    end

    def recipe_params
      Recipes::Params.get(params)
    end
  end
end
