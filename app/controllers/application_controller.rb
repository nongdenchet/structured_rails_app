class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :exception
  before_action :execute

  def execute
    begin
      render_response(find_and_create_service.execute)
    rescue StandardError => error
      render_response(error)
    end
  end

  private
  def find_and_create_service
    clazz = "#{find_module}::#{find_action}".constantize
    clazz.new(params, current_user)
  end

  def find_module
    controller_name.camelize
  end

  def find_action
    action_name.camelize
  end

  def render_response(data)
    respond_to do |format|
      format.json { render json: data.to_json }
    end
  end
end
