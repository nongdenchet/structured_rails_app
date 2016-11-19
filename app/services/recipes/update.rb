module Recipes
  class Update < Service
    def process
      recipe = Recipe.find(params[:id])
      authorize_record!(recipe)
      validate!
      recipe.update!(recipe_params)
      Recipes::ShortSerializer.new(recipe)
    end

    private
    def require_authen?
      true
    end

    def policy
      RecipePolicy
    end

    def validate!
      RecipeValidator.new(recipe_params).validate!
    end

    def recipe_params
      Recipes::Params.get(params)
    end
  end
end
