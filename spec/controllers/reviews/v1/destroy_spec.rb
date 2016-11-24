require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { create(:recipe, user: other_user) }
  let(:review) { create(:review, user: user, recipe: recipe) }

  before(:each) do
    set_version('v1')
  end

  describe 'DELETE #destroy' do
    it 'destroy complete' do
      sign_in user
      review
      expect {
        delete :destroy, id: review.id, format: :json
      }.to change(Review, :count).by(-1)
    end

    it 'return 404' do
      sign_in user
      delete :destroy, id: 100, format: :json
      assert_404
    end

    it 'return 403' do
      sign_in other_user
      delete :destroy, id: review.id, format: :json
      assert_403
    end

    it 'return 401' do
      post :create, id: review.id, format: :json
      assert_401
    end
  end
end
