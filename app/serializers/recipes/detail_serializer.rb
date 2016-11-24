module Recipes
  class DetailSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :image, :prepare_time, :cook_time, :ready_time,
               :complete_status, :complete_count, :review_count, :average_rating

    def initialize(record, extras = {})
      super(record)
      @extras = extras
    end

    belongs_to :user, serializer: Users::ShortSerializer
    has_many :ingredients, serializer: Ingredients::Serializer
    has_many :directions, serializer: Directions::Serializer
    has_many :complete_users, serializer: Users::ShortSerializer
    has_many :reviews, serializer: Reviews::ShortSerializer

    def complete_status
      @extras[:complete_status] || Completes::Status::INCOMPLETE
    end
  end
end
