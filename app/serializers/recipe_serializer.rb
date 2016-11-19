class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :prepare_time, :cook_time, :ready_time

  belongs_to :user, serializer: ShortUserSerializer
end
