require 'rails_helper'

RSpec.describe V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { create(:recipe, user: user) }

  describe 'POST #add_directions' do
    it 'create recipe' do
      sign_in user
      post :add_directions, directions: %w(1 2), id: recipe.id, format: :json
      recipe.reload
      expect(recipe.directions.map(&:content)).to match_array %w(1 2)
      expect(recipe.status).to eq(Recipes::Status::DONE)
    end

    it 'return errors' do
      sign_in user
      post :add_directions, directions: [], id: recipe.id, format: :json
      expect(json_response_error['message'].length).to eq(1)
    end

    it 'return 401' do
      post :add_directions, id: recipe.id, format: :json
      assert_401
    end

    it 'return 403' do
      sign_in other_user
      post :add_directions, id: recipe.id, format: :json
      assert_403
    end

    it 'return 404' do
      sign_in user
      post :add_directions, id: 1, format: :json
      assert_404
    end
  end
end
