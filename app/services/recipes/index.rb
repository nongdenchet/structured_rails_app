module Recipes
  class Index < Service
    def process
      recipes = user.recipes
      recipes.map { |recipe| Recipes::ShortSerializer.new(recipe) }
    end

    def require_authen?
      true
    end
  end
end
