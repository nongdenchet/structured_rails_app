module Recipes
  module V1
    class Create < Operation
      require_authen!

      def process
        validate!
        recipe = user.recipes.create!(recipe_params)
        Recipes::Serializer.new(recipe)
      end

      private
      def recipe_params
        params.require(:recipe).permit(
          :title,
          :description,
          :image,
          :prepare_time,
          :cook_time,
          :ready_time
        )
      end
    end
  end
end
