module Recipes
  class Destroy < Service
    require_authen!
    with_policy RecipePolicy

    def process
      recipe = Recipe.find(params[:id])
      authorize_record!(recipe)
      recipe.destroy!
      {success: true}
    end
  end
end
