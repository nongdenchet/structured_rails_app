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
      expect(json_response['status']).to eq(404)
      expect(json_response['code']).to eq('NOT_FOUND')
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
      expect(json_response['status']).to eq(401)
      expect(json_response['code']).to eq('UNAUTHORIZED')
    end
  end
end
