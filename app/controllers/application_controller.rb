class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :exception
  before_action :execute

  def execute
    begin
      render_response(service.execute)
    rescue StandardError => error
      render_response(error)
    end
  end

  private
  def service
    clazz = "#{find_module}::#{find_action}".constantize
    clazz.new(params, current_user)
  end

  def find_module
    StringUtils.capitalize_first(controller_name)
  end

  def find_action
    StringUtils.capitalize_first(action_name)
  end

  def render_response(data)
    respond_to do |format|
      format.json { render json: data.to_json }
    end
  end
end
