module Recipes
  class DetailQuery
    def execute
      Recipe
        .select('recipes.*, review_infos.average AS average_rating,
                 review_infos.count AS review_count,
                 complete_infos.count AS complete_count')
        .joins("LEFT OUTER JOIN (#{review_infos.to_sql}) AS review_infos
                ON review_infos.recipe_id = recipes.id")
        .joins("LEFT OUTER JOIN (#{complete_infos.to_sql}) AS complete_infos
                ON complete_infos.recipe_id = recipes.id")
    end

    private
    def review_infos
      Review
        .select('recipe_id, COALESCE(AVG(reviews.rating), 0) AS average,
                 COUNT(reviews.id) AS count')
        .group('recipe_id')
    end

    def complete_infos
      Complete
        .select('recipe_id, COUNT(completes.id) AS count')
        .group('recipe_id')
    end
  end
end
