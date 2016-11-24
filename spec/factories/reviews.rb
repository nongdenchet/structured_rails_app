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

FactoryGirl.define do
  factory :review do
    rating 3
    content Faker::Lorem.paragraph(1)
    user
    recipe
  end
end
