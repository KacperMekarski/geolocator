class IpstackAdapter < BaseAdapter
  API_URL = 'http://api.ipstack.com'.freeze

  def self.call(internet_protocol)
    url = API_URL + "/#{internet_protocol}"
    response = Faraday.get(url,
                           access_key: Rails.application.credentials.fetch(:ipstack_access_key),
                           fields: Geolocation::FIELDS.join(','))

    @response_body = JSON.parse(response.body)

    if @response_body['success'] == false && @response_body['error'].present?
      return Result.new(false, nil, :bad_gateway)
    end

    Result.new(true, @response_body)
  rescue Faraday::Error, Faraday::ConnectionFailed, Faraday::TimeoutError, Faraday::SSLError
    Result.new(false, nil, :bad_gateway)
  end
end
