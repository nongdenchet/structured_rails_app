module Recipes
  module V1
    class UpdateValidator < Validator
      attr_accessor :title, :description, :prepare_time, :cook_time, :ready_time, :image,
                    :ingredients, :directions

      validates :title, presence: true
      validates :image, presence: true
      validates :description, presence: true
      validates :prepare_time, numericality: true
      validates :cook_time, numericality: true
      validates :ready_time, numericality: true
      validates :ingredients, empty_array: true
      validates :directions, empty_array: true

      def self.require_params(params)
        params.permit!
        params.require(:recipe)
          .slice(:title, :description, :prepare_time, :cook_time, :ready_time,
                 :image, :ingredients, :directions)
      end
    end
  end
end
