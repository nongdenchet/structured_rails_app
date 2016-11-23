module Reviews
  module V1
    class CreateValidator < Validator
      attr_accessor :recipe_id, :content, :rating

      validates :content, presence: true
      validates :recipe_id, foreign_key: {target: Recipe}
      validates :rating, numericality: {only_integer: true,
                                        greater_than_or_equal_to: 1,
                                        less_than_or_equal_to: 5}

      def self.require_params(params)
        params.require(:review)
          .permit(:content, :rating, :recipe_id)
      end
    end
  end
end
