require 'rails_helper'

RSpec.describe 'API version', type: :request do
  it 'return not found version' do
    expect {
      get '/api/recipes', nil, {accept: 'application/json'}
    }.to raise_error ActionController::RoutingError
  end

  it 'return found version' do
    expect {
      get '/api/recipes', nil, {accept: 'application/json; version=v1'}
    }.not_to raise_error
  end
end
