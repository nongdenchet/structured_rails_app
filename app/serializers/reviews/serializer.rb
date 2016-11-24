module Reviews
  class Serializer < ActiveModel::Serializer
    attributes :id, :rating, :content, :created_at

    belongs_to :user, serializer: Users::ShortSerializer
    belongs_to :recipe, serializer: Recipes::SimpleSerializer
  end
end
