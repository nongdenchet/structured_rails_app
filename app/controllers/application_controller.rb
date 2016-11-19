class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :exception

  def run(service)
    begin
      render_response(service.execute)
    rescue StandardError => error
      render_response(error)
    end
  end

  private
  def render_response(data)
    respond_to do |format|
      format.json { render json: data.to_json }
    end
  end
end
