require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { create(:recipe, user: user) }

  before(:each) do
    set_version('v1')
  end

  describe 'DELETE #destroy' do
    it 'delete recipe' do
      sign_in user
      delete :destroy, id: recipe.id, format: :json
      expect(json_response['success']).to eq(true)
    end

    it 'return 401' do
      delete :destroy, id: 1, format: :json
      assert_401
    end

    it 'return 404' do
      sign_in user
      delete :destroy, id: 1, format: :json
      assert_404
    end

    it 'return 403' do
      sign_in other_user
      delete :destroy, id: recipe.id, format: :json
      assert_403
    end
  end
end
