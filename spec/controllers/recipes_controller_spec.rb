require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:recipe) { create(:recipe, user: user) }

    it 'return recipe' do
      get :show, id: recipe.id, format: :json
      expect(json_response['id']).to eq(recipe.id)
      expect(json_response['title']).to eq(recipe.title)
      expect(json_response['user']['id']).to eq(user.id)
    end

    it 'return error 404' do
      get :show, id: 1, format: :json
      expect(json_response_error['status']).to eq(404)
      expect(json_response_error['code']).to eq('NOT_FOUND')
    end
  end

  describe 'GET #index' do
    let(:user) { create(:user) }

    it 'return recipes' do
      3.times { create(:recipe, user: user) }
      sign_in user
      get :index, format: :json
      expect(json_response.length).to eq(3)
    end

    it 'return no recipes' do
      sign_in user
      get :index, format: :json
      expect(json_response.length).to eq(0)
    end

    it 'return 401' do
      get :index, format: :json
      expect(json_response_error['status']).to eq(401)
      expect(json_response_error['code']).to eq('UNAUTHORIZED')
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:other_user) { create(:other_user) }
    let(:recipe) { create(:recipe, user: user) }

    it 'delete recipe' do
      sign_in user
      delete :destroy, id: recipe.id, format: :json
      expect(json_response['success']).to eq(true)
    end

    it 'return 401' do
      delete :destroy, id: 1, format: :json
      expect(json_response_error['status']).to eq(401)
      expect(json_response_error['code']).to eq('UNAUTHORIZED')
    end

    it 'return 404' do
      sign_in user
      delete :destroy, id: 1, format: :json
      expect(json_response_error['status']).to eq(404)
      expect(json_response_error['code']).to eq('NOT_FOUND')
    end

    it 'return 403' do
      sign_in other_user
      delete :destroy, id: recipe.id, format: :json
      expect(json_response_error['status']).to eq(403)
      expect(json_response_error['code']).to eq('PERMISSION_DENIED')
    end
  end
end
