module Reviews
  module V1
    class Destroy < Service
      require_authen!

      def process
        authorize!(review)
        review.destroy!
        {success: true}
      end

      private
      def review
        @review ||= Review.find(params[:id])
      end
    end
  end
end
