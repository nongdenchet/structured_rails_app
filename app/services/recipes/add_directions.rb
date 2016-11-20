module Recipes
  class AddDirections < Service
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
        params[:directions].each do |content|
          recipe.directions.create!(content: content)
        end
        recipe.update!(status: Status::DONE)
      end
    end
  end
end
