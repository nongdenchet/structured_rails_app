require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before(:each) do
    set_version('v1')
  end

  describe 'GET #feeds' do
    it 'return recipes' do
      create(:recipe, user: user)
      %w(rain1@gmail.com rain2@gmail.com).each_with_index do |email, index|
        user = create(:user, email: email)
        create(:complete, recipe: recipe, user: user)
        create(:review, recipe: recipe, user: user, rating: index + 1)
      end
      sign_in user
      get :feeds, format: :json
      expect(json_response['recipes'].length).to eq(2)
      expect(json_response['users'].length).to eq(3)

      # Assert recipe_1
      recipe_1 = json_response['recipes'][0]
      expect(recipe_1['complete_count']).to eq(2)
      expect(recipe_1['review_count']).to eq(2)
      expect(recipe_1['average_rating'].to_f).to eq(1.5)

      # Assert recipe_2
      recipe_2 = json_response['recipes'][1]
      expect(recipe_2['complete_count']).to eq(0)
      expect(recipe_2['review_count']).to eq(0)
      expect(recipe_2['average_rating'].to_f).to eq(0)

      # Assert users
      complete_counts = json_response['users'].map { |user| user['complete_count'] }
      expect(complete_counts).to eq([1, 1, 0])
    end
  end
end
