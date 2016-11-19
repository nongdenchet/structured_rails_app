module Recipes
  class Index < Service
    def process
      recipes = user.recipes
      recipes.map { |recipe| serialize(recipe) }
    end

    private
    def require_authen?
      true
    end

    def serialize(recipe)
      Recipes::ShortSerializer.new(recipe)
    end
  end
end
