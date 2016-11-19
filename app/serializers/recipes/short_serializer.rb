module Recipes
  class ShortSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :image
  end
end
