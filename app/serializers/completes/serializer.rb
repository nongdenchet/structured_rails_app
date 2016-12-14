module Completes
  class Serializer < BaseSerializer
    attributes :id, :created_at

    belongs_to :user, serializer: Users::ShortSerializer
    belongs_to :recipe, serializer: Recipes::SimpleSerializer
  end
end
