module Recipes
  class ShortSerializer < BaseSerializer
    attributes :id, :title, :description, :image, :prepare_time, :cook_time, :ready_time,
               :complete_count, :review_count, :average_rating

    belongs_to :user, serializer: Users::ShortSerializer

    def review_count
      object.review_count || 0
    end

    def complete_count
      object.complete_count || 0
    end

    def average_rating
      object.average_rating || 0
    end
  end
end
