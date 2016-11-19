class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :exception

  def run(service)
    begin
      render json: service.execute.to_json
    rescue StandardError => error
      render json: error.to_json
    end
  end
end
