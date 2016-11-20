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

FactoryGirl.define do
  factory :direction do
    content Faker::Lorem.characters(100)
    recipe
  end
end
