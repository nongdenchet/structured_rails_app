module Recipes
  module V1
    class AddIngredients < Service
      require_authen!

      def process
        authorize!(recipe)
        validate!
        do_transaction
        {success: true}
      end

      private
      def recipe
        @recipe ||= Recipe.find(params[:id])
      end

      def do_transaction
        ActiveRecord::Base.transaction do
          Ingredient.import(build_ingredients)
          recipe.update!(status: Recipes::Status::DIRECTION)
        end
      end

      def build_ingredients
        params[:ingredients].reduce([]) do |result, content|
          result << recipe.ingredients.build(content: content)
        end
      end
    end
  end
end
