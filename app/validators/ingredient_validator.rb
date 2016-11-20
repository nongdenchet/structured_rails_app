class IngredientValidator < Validator
  attr_accessor :content

  validates :content, presence: true
end
