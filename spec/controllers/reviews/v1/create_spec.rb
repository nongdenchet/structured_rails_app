require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { create(:recipe, user: other_user) }
  let(:invalid_recipe) { create(:recipe, user: user) }
  let(:review_params) { {content: 'content', rating: 4, recipe_id: recipe.id} }
  let(:invalid_review_params) { {content: 'content', rating: 100, recipe_id: recipe.id} }

  before(:each) do
    set_version('v1')
  end

  describe 'POST #create' do
    it 'create complete' do
      sign_in user
      expect {
        post :create, review: review_params, format: :json
      }.to change(Review, :count).by(1)
      expect(json_response['user']['id']).to eq(user.id)
      expect(json_response['recipe']['id']).to eq(recipe.id)
      expect(json_response).to have_key('id')
      expect(json_response).to have_key('created_at')
      expect(json_response['rating']).to eq(4)
      expect(json_response['content']).to eq('content')
    end

    it 'return error when owner try to complete recipe' do
      sign_in user
      post :create, review: review_params.merge!(recipe_id: invalid_recipe.id), format: :json
      expect(json_response_error['message']).to eq('User can not review his/her own recipe')
      expect(json_response_error['code']).to eq('IS_OWNER')
    end

    it 'return error when user try complete recipe twice' do
      sign_in user
      create(:review, user: user, recipe: recipe)
      post :create, review: review_params, format: :json
      expect(json_response_error['message']).to eq('You have already reviewed this recipe')
      expect(json_response_error['code']).to eq('ALREADY_REVIEW')
    end

    it 'return 422' do
      sign_in user
      post :create, review: invalid_review_params, format: :json
      assert_422
    end

    it 'return 404' do
      sign_in user
      post :create, review: review_params.merge!(recipe_id: 100), format: :json
      assert_404
    end

    it 'return 401' do
      post :create, review: review_params, format: :json
      assert_401
    end
  end
end
