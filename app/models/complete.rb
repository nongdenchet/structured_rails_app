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

class Complete < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
end
