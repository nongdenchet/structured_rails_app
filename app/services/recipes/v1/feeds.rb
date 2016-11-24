module Recipes
  module V1
    class Feeds < Service
      require_authen!

      def process
        recipes.map { |recipe| serialize(recipe) }
      end

      private
      def recipes
        Recipes::DetailQuery.new
          .execute
          .order(created_at: :desc)
      end

      def serialize(recipe)
        Recipes::ShortSerializer.new(recipe)
      end
    end
  end
end
