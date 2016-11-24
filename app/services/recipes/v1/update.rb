module Recipes
  module V1
    class Update < Service
      require_authen!

      def process
        authorize!(recipe)
        validate!
        do_transaction
        Recipes::Serializer.new(recipe)
      end

      private
      def recipe
        @recipe ||= Recipe.find(params[:id])
      end

      def do_transaction
        ActiveRecord::Base.transaction do
          recipe.update!(recipe_params)
          recipe.ingredients.replace(build_ingredients)
          recipe.directions.replace(build_directions)
        end
      end

      def build_directions
        params[:recipe][:directions].map do |content|
          Direction.new(content: content)
        end
      end

      def build_ingredients
        params[:recipe][:ingredients].map do |content|
          Ingredient.new(content: content)
        end
      end

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
