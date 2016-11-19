require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe_attrs) { attributes_for(:recipe) }
  let(:recipe) { create(:recipe, user: user) }

  describe 'GET #index' do
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

  describe 'POST #create' do
    it 'create recipe' do
      sign_in user
      expect {
        post :create, recipe: recipe_attrs, format: :json
      }.to change(Recipe, :count).by(1)
      expect(json_response['title']).to eq(recipe_attrs[:title])
      expect(json_response['description']).to eq(recipe_attrs[:description])
    end

    it 'return errors' do
      sign_in user
      post :create, recipe: {title: ''}, format: :json
      expect(json_response_error.length).to eq(5)
    end

    it 'return 401' do
      post :create, recipe: recipe_attrs, format: :json
      expect(json_response_error['status']).to eq(401)
      expect(json_response_error['code']).to eq('UNAUTHORIZED')
    end
  end

  describe 'GET #show' do
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

  describe 'PUT #update' do
    it 'create recipe' do
      sign_in user
      put :update, id: recipe.id, recipe: recipe_attrs, format: :json
      expect(json_response['title']).to eq(recipe_attrs[:title])
      expect(json_response['description']).to eq(recipe_attrs[:description])
    end

    it 'return errors' do
      sign_in user
      put :update, id: recipe.id, recipe: {title: ''}, format: :json
      expect(json_response_error.length).to eq(5)
    end

    it 'return 401' do
      put :update, id: recipe.id, recipe: recipe_attrs, format: :json
      expect(json_response_error['status']).to eq(401)
      expect(json_response_error['code']).to eq('UNAUTHORIZED')
    end

    it 'return 404' do
      sign_in user
      put :update, id: 1, recipe: recipe_attrs, format: :json
      expect(json_response_error['status']).to eq(404)
      expect(json_response_error['code']).to eq('NOT_FOUND')
    end

    it 'return 403' do
      sign_in other_user
      put :update, id: recipe.id, recipe: recipe_attrs, format: :json
      expect(json_response_error['status']).to eq(403)
      expect(json_response_error['code']).to eq('PERMISSION_DENIED')
    end
  end

  describe 'DELETE #destroy' do
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
