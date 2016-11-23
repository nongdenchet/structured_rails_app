require 'rails_helper'

RSpec.describe Api::V1::CompletesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:recipe) { create(:recipe, user: other_user) }
  let(:recipe_1) { create(:recipe, user: create(:user, email: 'email@gmail.com')) }
  let(:complete) { create(:complete, user: user, recipe: recipe) }

  before(:each) do
    set_version('v1')
  end

  describe 'DELETE #destroy' do
    it 'destroy complete' do
      sign_in user
      complete
      expect {
        delete :destroy, recipe_id: complete.recipe_id, format: :json
      }.to change(Complete, :count).by(-1)
    end

    it 'return 404' do
      sign_in user
      delete :destroy, recipe_id: 100, format: :json
      assert_404
    end

    it 'return 404' do
      sign_in user
      delete :destroy, recipe_id: recipe_1.id, format: :json
      assert_404
    end

    it 'return 404' do
      sign_in other_user
      delete :destroy, recipe_id: complete.recipe_id, format: :json
      assert_404
    end

    it 'return 401' do
      post :create, recipe_id: complete.recipe_id, format: :json
      assert_401
    end
  end
end
