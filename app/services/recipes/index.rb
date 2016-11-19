module Recipes
  class Index < Service
    def process
      recipes = user.recipes
      recipes.map { |recipe| serialize(recipe) }
    end

    protected
    def require_authen?
      true
    end

    private
    def serialize(recipe)
      Recipes::ShortSerializer.new(recipe)
    end
  end
end
