require 'rails_helper'

RSpec.describe Api::V1::CompletesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { create(:recipe, user: other_user) }
  let(:invalid_recipe) { create(:recipe, user: user) }

  before(:each) do
    set_version('v1')
  end

  describe 'POST #create' do
    it 'create complete' do
      sign_in user
      expect {
        post :create, recipe_id: recipe.id, format: :json
      }.to change(Complete, :count).by(1)
      expect(json_response['user']['id']).to eq(user.id)
      expect(json_response['recipe']['id']).to eq(recipe.id)
      expect(json_response).to have_key('id')
      expect(json_response).to have_key('created_at')
    end

    it 'return error when owner try to complete recipe' do
      sign_in user
      post :create, recipe_id: invalid_recipe.id, format: :json
      expect(json_response_error['message']).to eq('User can not complete his/her own recipe')
      expect(json_response_error['code']).to eq('NOT_OWNER')
    end

    it 'return error when user try complete recipe twice' do
      sign_in user
      create(:complete, user: user, recipe: recipe)
      post :create, recipe_id: recipe.id, format: :json
      expect(json_response_error['message']).to eq('You have already completed this recipe')
      expect(json_response_error['code']).to eq('ALREADY_COMPLETE')
    end

    it 'return 404' do
      sign_in user
      post :create, recipe_id: 100, format: :json
      assert_404
    end

    it 'return 401' do
      post :create, recipe_id: recipe.id, format: :json
      assert_401
    end
  end
end
