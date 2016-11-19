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

class Ingredient < ApplicationRecord
  belongs_to :recipe
end
