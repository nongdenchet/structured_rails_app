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
      expect(json_response.length).to eq(2)

      # Assert recipe1
      recipe1 = json_response[0]
      expect(recipe1['complete_count']).to eq(2)
      expect(recipe1['review_count']).to eq(2)
      expect(recipe1['average_rating'].to_f).to eq(1.5)

      # Assert recipe2
      recipe2 = json_response[1]
      expect(recipe2['complete_count']).to eq(0)
      expect(recipe2['review_count']).to eq(0)
      expect(recipe2['average_rating'].to_f).to eq(0)
    end
  end
end
