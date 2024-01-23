class IpstackAdapter
  WrongIpError = Class.new(StandardError)

  API_URL = 'http://api.ipstack.com'.freeze

  def self.call(internet_protocol)
    url = API_URL + "/#{internet_protocol}"
    response = Faraday.get(url,
                           access_key: Rails.application.credentials.fetch(:ipstack_access_key),
                           fields: Geolocation::FIELDS.join(','))

    @response_body = JSON.parse(response.body)
    check_for_errors
    @response_body
  end

  def self.check_for_errors
    raise WrongIpError, 'Wrong IP' if @response_body.except('ip').values.uniq[0].nil?
  end
end
