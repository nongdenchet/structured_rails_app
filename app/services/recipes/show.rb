module Recipes
  class Show < Service
    def process
      Recipe.find(params[:id])
    end

    private
    def serializer
      RecipeSerializer
    end
  end
end
