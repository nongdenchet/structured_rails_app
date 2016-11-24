# == Schema Information
#
# Table name: recipes
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  image        :string
#  prepare_time :integer
#  cook_time    :integer
#  ready_time   :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  status       :integer          default("0")
#

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:ingredients).dependent(:destroy) }
    it { is_expected.to have_many(:completes).dependent(:destroy) }
    it { is_expected.to have_many(:complete_users).through(:completes).source(:user) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  describe 'properties' do
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:prepare_time) }
    it { is_expected.to respond_to(:cook_time) }
    it { is_expected.to respond_to(:ready_time) }
  end
end
