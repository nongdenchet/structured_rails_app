# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  content    :string
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :ingredient do
    content Faker::Lorem.characters(100)
    recipe
  end
end
