class URLValidator < ActiveModel::EachValidator
  def self.valid?(url)
    uri = begin
      URI.parse(url)
    rescue URI::InvalidURIError
      return false
    end

    uri.host.present? && uri.is_a?(URI::HTTP)
  end
end
