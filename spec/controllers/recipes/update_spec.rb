require 'rails_helper'

RSpec.describe V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe_attrs) {
    attributes_for(:recipe).merge(ingredients: %w(1 2), directions: %w(3 4))
  }
  let(:invalid_recipe_attrs) { attributes_for(:recipe) }
  let(:recipe) { create(:recipe, user: user) }

  describe 'PUT #update' do
    it 'create recipe' do
      sign_in user
      put :update, id: recipe.id, recipe: recipe_attrs, format: :json
      expect(json_response['title']).to eq(recipe_attrs[:title])
      expect(json_response['description']).to eq(recipe_attrs[:description])
      expect(recipe.ingredients.map(&:content)).to match_array %w(1 2)
      expect(recipe.directions.map(&:content)).to match_array %w(3 4)
    end

    it 'return errors' do
      sign_in user
      put :update, id: recipe.id, recipe: invalid_recipe_attrs, format: :json
      expect(json_response_error['message'].length).to eq(2)
    end

    it 'return errors' do
      sign_in user
      put :update, id: recipe.id, recipe: {title: ''}, format: :json
      expect(json_response_error['message'].length).to eq(8)
    end

    it 'return 401' do
      put :update, id: recipe.id, recipe: recipe_attrs, format: :json
      assert_401
    end

    it 'return 404' do
      sign_in user
      put :update, id: 1, recipe: recipe_attrs, format: :json
      assert_404
    end

    it 'return 403' do
      sign_in other_user
      put :update, id: recipe.id, recipe: recipe_attrs, format: :json
      assert_403
    end
  end
end
