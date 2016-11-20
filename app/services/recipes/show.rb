module Recipes
  class Show < Service
    def process
      Recipes::DetailSerializer.new(query_recipe)
    end

    private
    def query_recipe
      Recipe.includes(:ingredients, :directions)
        .find(params[:id])
    end
  end
end
