class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

  def create
    result = create_service.new(params).call

    if result.success?
      render jsonapi: result.value, include: [:geolocation]
    else
      render_error(result.error, status: result.error)
    end
  end

  def show
    if stale?(etag: [resource, params[:include]&.to_s, params[:fields]&.to_s], last_modified: resource.updated_at.utc, public: true)
      render jsonapi: resource, include: [:geolocation], cache: Rails.cache
    end
  end

  def destroy
    resource.destroy!
    head :ok
  end

  protected

  def resource
    raise NotImplementedError
  end

  def create_service
    raise NotImplementedError
  end

  def render_not_found_error
    render_error('Not found', status: 404)
  end

  def render_error(message, status:)
    render jsonapi_errors: { detail: message }, status: status
  end
end
