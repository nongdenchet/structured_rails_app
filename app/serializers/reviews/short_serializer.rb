module Reviews
  class ShortSerializer < BaseSerializer
    attributes :id, :rating, :content, :created_at

    belongs_to :user, serializer: Users::ShortSerializer
  end
end
