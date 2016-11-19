require 'rails_helper'

RSpec.describe RecipeValidator, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:image) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_numericality_of(:prepare_time) }
  it { is_expected.to validate_numericality_of(:cook_time) }
  it { is_expected.to validate_numericality_of(:ready_time) }
end
