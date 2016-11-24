require 'rails_helper'

RSpec.describe Reviews::V1::CreateValidator, type: :model do
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_numericality_of(:rating).only_integer }
  it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(1) }
  it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(5) }

  it 'should be valid' do
    recipe = create(:recipe)
    expect(validate({content: 'content', rating: 1, recipe_id: recipe.id})).to eq(true)
  end

  it 'should be invalid due to recipe not found' do
    expect(validate({content: 'content', rating: 1, recipe_id: 100})).to eq(false)
  end

  def validate(params)
    Reviews::V1::CreateValidator.new(params).valid?
  end
end
