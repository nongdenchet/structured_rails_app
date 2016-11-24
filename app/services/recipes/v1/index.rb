module Recipes
  module V1
    class Index < Service
      require_authen!

      def process
        recipes.map { |recipe| serialize(recipe) }
      end

      private
      def recipes
        Recipes::DetailQuery.new
          .execute
          .where(user_id: user.id)
          .order(updated_at: :desc)
      end

      def serialize(recipe)
        Recipes::ShortSerializer.new(recipe)
      end
    end
  end
end
