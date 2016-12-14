module Recipes
  class SimpleSerializer < BaseSerializer
    attributes :id, :title, :description, :image, :prepare_time, :cook_time, :ready_time
  end
end
