require 'rails_helper'

RSpec.describe 'API version', type: :request do
  it 'return not found version' do
    expect {
      get '/api/recipes/index', nil, {version: 200, accept: 'application/json'}
    }.to raise_error ActionController::RoutingError
  end

  it 'return not found version' do
    expect {
      get '/api/recipes/index', nil, {accept: 'application/json'}
    }.to raise_error ActionController::RoutingError
  end

  it 'return found version' do
    expect {
      get '/api/recipes/index', nil, {version: 'v1', accept: 'application/json'}
    }.not_to raise_error
  end
end
