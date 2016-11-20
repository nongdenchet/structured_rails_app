class DirectionValidator < Validator
  attr_accessor :content

  validates :content, presence: true
end
