module Completes
  module V1
    class Destroy < Service
      require_authen!

      def process
        complete.destroy!
        {success: true}
      end

      private
      def complete
        @complete ||= Complete.find_by!(user_id: user.id, recipe_id: recipe.id)
      end

      def recipe
        @recipe ||= Recipe.find(params[:recipe_id])
      end
    end
  end
end
