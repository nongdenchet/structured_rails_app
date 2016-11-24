module Users
  class CompleteSerializer < ActiveModel::Serializer
    attributes :id, :name, :image, :complete_count

    def complete_count
      object.complete_count || 0
    end
  end
end
