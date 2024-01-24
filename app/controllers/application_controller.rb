class ApplicationController < ActionController::API
  def create
    result = create_service.new(params).call

    if result.success?
      render_serialized_payload { serialize_resource(result.value) }
    else
      render_error_payload(result.error, result.error)
    end
  end

  def show
    return record_not_found if resource.nil?

    if stale?(etag: resource, last_modified: resource.updated_at.utc, public: true)
      render_serialized_payload { serialize_resource(resource) }
    end
  end

  def destroy
    return record_not_found if resource.nil?

    resource.destroy!
    head :ok
  end

  protected

  def resource
    raise NotImplementedError
  end

  def resource_serializer
    raise NotImplementedError
  end

  def create_service
    raise NotImplementedError
  end

  def render_serialized_payload(status = 200)
    render json: yield, status: status, content_type: content_type
  end

  def render_error_payload(error, status = 422)
    render json: { error: error }, status: status, content_type: content_type
  end

  def serialize_resource(resource)
    resource_serializer.new(
      resource,
      include: [:geolocation]
    ).serializable_hash
  end

  def record_not_found
    render_error_payload('Resource not found', 404)
  end

  def content_type
    'application/vnd.api+json'
  end
end
