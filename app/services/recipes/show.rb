module Recipes
  class Show < Service
    def process
      recipe = Recipe.find(params[:id])
      Recipes::DetailSerializer.new(recipe)
    end
  end
end
