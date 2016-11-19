module Recipes
  class Params
    def self.get(params)
      params.require(:recipe).permit(
        :title,
        :description,
        :prepare_time,
        :cook_time,
        :ready_time
      )
    end
  end
end
