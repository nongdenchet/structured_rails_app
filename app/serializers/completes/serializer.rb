module Completes
  class Serializer < ActiveModel::Serializer
    attributes :id, :created_at

    belongs_to :user, serializer: Users::ShortSerializer
    belongs_to :recipe, serializer: Recipes::ShortSerializer
  end
end
