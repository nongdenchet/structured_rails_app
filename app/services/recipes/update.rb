module Recipes
  class Update < Service
    require_authen!
    with_policy RecipePolicy

    def process
      recipe = Recipe.find(params[:id])
      authorize_record!(recipe)
      validate!
      recipe.update!(recipe_params)
      Recipes::ShortSerializer.new(recipe)
    end

    private
    def validate!
      RecipeValidator.new(recipe_params).validate!
    end

    def recipe_params
      Recipes::Params.get(params)
    end
  end
end
