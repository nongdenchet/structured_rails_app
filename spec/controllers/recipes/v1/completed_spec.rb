require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before(:each) do
    set_version('v1')
  end

  describe 'GET #index' do
    it 'return recipes' do
      2.times { create(:complete, user: user, recipe: recipe) }
      sign_in user
      get :completed, format: :json
      expect(json_response.length).to eq(2)
    end

    it 'return no recipes' do
      sign_in user
      get :completed, format: :json
      expect(json_response.length).to eq(0)
    end

    it 'return 401' do
      get :completed, format: :json
      assert_401
    end
  end
end
