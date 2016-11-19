module Users
  class ShortSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
