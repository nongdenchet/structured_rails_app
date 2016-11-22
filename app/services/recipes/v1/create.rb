module Recipes
  module V1
    class Create < Service
      require_authen!

      def process
        validate!
        recipe = user.recipes.create!(recipe_params)
        Recipes::ShortSerializer.new(recipe)
      end

      private
      def recipe_params
        Recipes::Params.get(params)
      end
    end
  end
end
