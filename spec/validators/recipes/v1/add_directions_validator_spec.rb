require 'rails_helper'

RSpec.describe Recipes::V1::AddDirectionsValidator, type: :model do
  it 'return false when empty params' do
    expect(check_valid?({})).to eq(false)
  end

  it 'return false when empty contents' do
    expect(check_valid?({directions: []})).to eq(false)
  end

  it 'return false when empty individual content' do
    expect(check_valid?({directions: ['', 'data']})).to eq(false)
  end

  it 'return true' do
    expect(check_valid?({directions: %w(data data1)})).to eq(true)
  end

  def check_valid?(params)
    Recipes::V1::AddDirectionsValidator.new(params).valid?
  end
end
