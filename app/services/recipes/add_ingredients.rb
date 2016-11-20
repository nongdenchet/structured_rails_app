module Recipes
  class AddIngredients < Service
    require_authen!

    def process
      authorize_record!(recipe)
      validate!
      do_transaction
      {success: true}
    end

    private
    def recipe
      @recipe ||= Recipe.find(params[:id])
    end

    def do_transaction
      ActiveRecord::Base.transaction do
        params[:ingredients].each do |content|
          recipe.ingredients.create!(content: content)
        end
        recipe.update!(status: Status::DIRECTION)
      end
    end
  end
end
