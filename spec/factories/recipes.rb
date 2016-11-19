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
#

FactoryGirl.define do
  factory :recipe do
    title Faker::Name.first_name
    description Faker::Lorem.paragraph(1)
    prepare_time 5
    cook_time 10
    ready_time 5
    user
  end
end
