module Users
  class CompleteSerializer < BaseSerializer
    attributes :id, :name, :image, :complete_count

    def complete_count
      object.complete_count || 0
    end
  end
end
