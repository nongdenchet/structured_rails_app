require 'rails_helper'

RSpec.describe Recipes::V1::AddIngredientsValidator, type: :model do
  it 'return false when empty params' do
    expect(check_valid?({})).to eq(false)
  end

  it 'return false when empty contents' do
    expect(check_valid?({ingredients: []})).to eq(false)
  end

  it 'return false when empty individual content' do
    expect(check_valid?({ingredients: ['', 'data']})).to eq(false)
  end

  it 'return true' do
    expect(check_valid?({ingredients: %w(data data1)})).to eq(true)
  end

  def check_valid?(params)
    Recipes::V1::AddIngredientsValidator.new(params).valid?
  end
end
