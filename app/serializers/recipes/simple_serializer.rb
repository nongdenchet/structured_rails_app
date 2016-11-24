module Recipes
  class SimpleSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :image, :prepare_time, :cook_time, :ready_time
  end
end
