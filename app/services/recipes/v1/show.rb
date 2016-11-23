module Recipes
  module V1
    class Show < Service
      def process
        authorize_record!(recipe, NotFound)
        Recipes::DetailSerializer.new(recipe)
      end

      private
      def recipe
        @recipe ||= Recipe.includes(:ingredients, :directions, :complete_users)
                      .find(params[:id])
      end
    end
  end
end
