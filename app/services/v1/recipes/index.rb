module V1::Recipes
  class Index < Service
    require_authen!

    def process
      recipes = user.recipes
      recipes.map { |recipe| serialize(recipe) }
    end

    private
    def serialize(recipe)
      Recipes::ShortSerializer.new(recipe)
    end
  end
end
