module Recipes
  module V1
    class Completed < Operation
      require_authen!

      def process
        recipes = user.complete_recipes
        recipes.map { |recipe| serialize(recipe) }
      end

      private
      def serialize(recipe)
        Recipes::SimpleSerializer.new(recipe)
      end
    end
  end
end
