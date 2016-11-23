require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe_attrs) { attributes_for(:recipe) }

  before(:each) do
    set_version('v1')
  end

  describe 'POST #create' do
    it 'create recipe' do
      sign_in user
      expect {
        post :create, recipe: recipe_attrs, format: :json
      }.to change(Recipe, :count).by(1)
      expect(json_response['title']).to eq(recipe_attrs[:title])
      expect(json_response['description']).to eq(recipe_attrs[:description])
      expect(Recipe.last.status).to eq(Recipes::Status::INGREDIENT)
    end

    it 'return errors' do
      sign_in user
      post :create, recipe: {title: ''}, format: :json
      expect(json_response_error['message'].length).to eq(6)
      assert_422
    end

    it 'return 401' do
      post :create, recipe: recipe_attrs, format: :json
      assert_401
    end
  end
end
