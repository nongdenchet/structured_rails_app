module Recipes
  class Destroy < Service
    def process
      recipe = Recipe.find(params[:id])
      authorize_record!(recipe)
      recipe.destroy!
      {success: true}
    end

    private
    def require_authen?
      true
    end

    def policy
      RecipePolicy
    end
  end
end
