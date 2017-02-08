module Recipes
  module V1
    class Destroy < Operation
      require_authen!

      def process
        recipe = Recipe.find(params[:id])
        authorize!(recipe)
        recipe.destroy!
        {success: true}
      end
    end
  end
end
