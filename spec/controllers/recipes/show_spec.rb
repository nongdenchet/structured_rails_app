require 'rails_helper'

RSpec.describe V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  describe 'GET #show' do
    it 'return recipe' do
      2.times { create(:direction, recipe: recipe) }
      2.times { create(:ingredient, recipe: recipe) }
      get :show, id: recipe.id, format: :json
      expect(json_response['id']).to eq(recipe.id)
      expect(json_response['title']).to eq(recipe.title)
      expect(json_response['user']['id']).to eq(user.id)
      expect(json_response['directions'].length).to eq(2)
      expect(json_response['ingredients'].length).to eq(2)
    end

    it 'return error 404' do
      get :show, id: 1, format: :json
      assert_404
    end
  end
end
