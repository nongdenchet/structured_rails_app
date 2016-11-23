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

class Recipe < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy
  has_many :completes, dependent: :destroy
  has_many :complete_users, through: :completes, source: :user
end
