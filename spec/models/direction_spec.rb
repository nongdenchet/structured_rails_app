# == Schema Information
#
# Table name: directions
#
#  id         :integer          not null, primary key
#  content    :text
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Direction, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:recipe) }
  end

  describe 'properties' do
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:recipe_id) }
  end
end
