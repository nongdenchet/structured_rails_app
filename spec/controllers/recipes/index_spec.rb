require 'rails_helper'

RSpec.describe V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
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
      assert_401
    end
  end
end
