class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

  def show
    render jsonapi: resource, include: [:geolocation]
  end

  def destroy
    resource.destroy!
    head :ok
  end

  protected

  def resource
    raise NotImplementedError
  end

  def render_not_found_error
    render_error('Not found', status: 404)
  end

  def render_error(message, status:)
    render jsonapi_errors: { detail: message }, status: status
  end
end
