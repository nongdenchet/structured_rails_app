module Users
  class ShortSerializer < ActiveModel::Serializer
    attributes :id, :name, :image
  end
end
