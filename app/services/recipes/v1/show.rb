module Recipes
  module V1
    class Show < Service
      def process
        authorize_record!(recipe, NotFound)
        Recipes::DetailSerializer.new(recipe, extras)
      end

      private
      def extras
        {complete_status: complete_status}
      end

      def complete_status
        return Completes::Status::OWNER if is_owner?
        return Completes::Status::COMPLETED if is_complete?
        Completes::Status::INCOMPLETE
      end

      def is_owner?
        user.try(:id) == recipe.user_id
      end

      def is_complete?
        Complete.exists?(user_id: user.try(:id), recipe_id: recipe.id)
      end

      def recipe
        @recipe ||= detail_query.execute
      end

      def detail_query
        Recipes::DetailQuery.new(params[:id])
      end
    end
  end
end
