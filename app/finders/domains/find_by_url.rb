module Domains
  class FindByURL
    def initialize(url, validator)
      @url = url
      @validator = validator
    end

    def call
      Domain.find_by(name: domain_name)
    end

    private

    def domain_name
      @domain_name ||= URI.parse(@url).host if @validator.valid?(@url)
    end
  end
end
