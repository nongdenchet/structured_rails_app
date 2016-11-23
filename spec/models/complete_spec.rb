# == Schema Information
#
# Table name: completes
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Complete, type: :model do
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:recipe_id) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:recipe) }
end
