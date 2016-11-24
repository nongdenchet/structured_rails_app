module Reviews
  module V1
    class Create < Service
      require_authen!

      def process
        authorize_record!(recipe, Reviews::OwnerError)
        check_has_reviewed!
        validate!
        review = user.reviews.create(review_params)
        Reviews::Serializer.new(review)
      end

      private
      def check_has_reviewed!
        review = Review.find_by(recipe_id: recipe.id, user_id: user.id)
        raise Reviews::AlreadyExistedError if review
      end

      def recipe
        @recipe ||= Recipe.find(params[:review][:recipe_id])
      end

      def review_params
        params.require(:review).permit(
          :content,
          :rating,
          :recipe_id
        )
      end
    end
  end
end
