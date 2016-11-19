class RecipeValidator < Validator
  attr_accessor :title, :description, :prepare_time, :cook_time, :ready_time

  validates :title, presence: true
  validates :description, presence: true
  validates :prepare_time, numericality: true
  validates :cook_time, numericality: true
  validates :ready_time, numericality: true
end
