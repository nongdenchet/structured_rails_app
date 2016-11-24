require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:user_1) { create(:user, email: 'email1@gmail.com') }
  let(:user_2) { create(:user, email: 'email2@gmail.com') }
  let(:recipe) { create(:recipe, user: user, status: Recipes::Status::DONE) }
  let(:recipe_1) { create(:recipe, user: user, status: Recipes::Status::INGREDIENT) }
  let(:recipe_2) { create(:recipe, user: user, status: Recipes::Status::DIRECTION) }

  before(:each) do
    set_version('v1')
  end

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

    it 'return statistic data' do
      %w(rain1@gmail.com rain2@gmail.com).each_with_index do |email, index|
        user = create(:user, email: email)
        create(:complete, recipe: recipe, user: user)
        create(:review, recipe: recipe, user: user, rating: index + 1)
      end
      get :show, id: recipe.id, format: :json
      expect(json_response['id']).to eq(recipe.id)
      expect(json_response['complete_count']).to eq(2)
      expect(json_response['review_count']).to eq(2)
      expect(json_response['average_rating'].to_f).to eq(1.5)
      expect(json_response['reviews'].length).to eq(2)
      expect(json_response['complete_users'].length).to eq(2)
    end

    it 'return recipe with complete users' do
      create(:complete, recipe: recipe, user: user_1)
      create(:complete, recipe: recipe, user: user_2)
      get :show, id: recipe.id, format: :json
      expect(json_response['complete_users'].length).to eq(2)
    end

    it 'return complete status owner' do
      sign_in user
      get :show, id: recipe.id, format: :json
      expect(json_response['complete_status']).to eq(Completes::Status::OWNER)
    end

    it 'return complete status complete' do
      create(:complete, recipe: recipe, user: user_1)
      sign_in user_1
      get :show, id: recipe.id, format: :json
      expect(json_response['complete_status']).to eq(Completes::Status::COMPLETED)
    end

    it 'return complete status incomplete' do
      sign_in user_1
      get :show, id: recipe.id, format: :json
      expect(json_response['complete_status']).to eq(Completes::Status::INCOMPLETE)
    end

    it 'return complete status incomplete' do
      get :show, id: recipe.id, format: :json
      expect(json_response['complete_status']).to eq(Completes::Status::INCOMPLETE)
    end

    it 'not return incomplete recipe' do
      get :show, id: recipe_1.id, format: :json
      assert_404
    end

    it 'not return incomplete recipe' do
      get :show, id: recipe_2.id, format: :json
      assert_404
    end

    it 'return error 404' do
      get :show, id: 1, format: :json
      assert_404
    end
  end
end
