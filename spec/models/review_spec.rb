# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  content    :text
#  rating     :integer
#  recipe_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:rating) }
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:recipe_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:recipe) }
  end
end
