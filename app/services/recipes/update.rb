module Recipes
  class Update < Service
    require_authen!

    def process
      recipe = Recipe.find(params[:id])
      authorize_record!(recipe)
      validate!
      recipe.update!(recipe_params)
      Recipes::ShortSerializer.new(recipe)
    end

    private
    def recipe_params
      Recipes::Params.get(params)
    end
  end
end
