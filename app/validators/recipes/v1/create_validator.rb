module Recipes
  module V1
    class CreateValidator < Validator
      attr_accessor :title, :description, :prepare_time, :cook_time, :ready_time, :image

      validates :title, presence: true
      validates :image, presence: true
      validates :description, presence: true
      validates :prepare_time, numericality: true
      validates :cook_time, numericality: true
      validates :ready_time, numericality: true

      def self.require_params(params)
        params.require(:recipe)
          .permit(:title, :description, :prepare_time, :cook_time, :ready_time, :image)
      end
    end
  end
end
