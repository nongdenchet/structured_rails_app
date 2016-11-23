class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery unless: -> { request.format.json? }

  def execute
    begin
      render_response(find_and_create_service.execute)
    rescue BaseError => error
      render_response(error)
    end
  end

  private
  def find_version
    request.headers.fetch(:version).upcase
  end

  def find_and_create_service
    clazz = "#{find_module}::#{find_version}::#{find_action}".constantize
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
      format.json { render_json data }
    end
  end

  def render_json(data)
    if data.kind_of?(BaseError)
      render json: data.to_json, status: data.status
    else
      render json: data.to_json
    end
  end
end
