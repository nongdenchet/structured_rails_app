module Recipes
  module V1
    class Feeds < Service
      require_authen!

      def process
        result.new(recipes, users)
      end

      private
      def recipes
        Recipes::DetailQuery.new
          .execute
          .includes(:user)
          .order(created_at: :desc)
          .map { |recipe| Recipes::ShortSerializer.new(recipe) }
      end

      def users
        Users::BestCompleteQuery.new
          .execute
          .map { |recipe| Users::CompleteSerializer.new(recipe) }
      end

      def result
        Struct.new(:recipes, :users)
      end
    end
  end
end
