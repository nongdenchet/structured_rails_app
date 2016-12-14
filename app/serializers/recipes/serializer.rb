module Recipes
  class Serializer < BaseSerializer
    attributes :id, :title, :description, :image, :prepare_time, :cook_time, :ready_time

    belongs_to :user, serializer: Users::ShortSerializer
    has_many :ingredients, serializer: Ingredients::Serializer
    has_many :directions, serializer: Directions::Serializer
  end
end
