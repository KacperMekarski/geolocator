module Domains
  class Process < BaseService
    def initialize(params, url_validator = URLValidator, domain_finder = Domains::FindByURL, ip_address_processor = IPAddresses::Process)
      @url = URLSanitizer.call(params[:url])
      @url_validator = url_validator
      @domain_finder = domain_finder
      @ip_address_processor = ip_address_processor
    end

    def call
      return Result.new(false, nil, :unprocessable_entity) unless @url_validator.valid?(@url)

      domain = @domain_finder.new(@url, @url_validator).call
      return Result.new(true, domain) if domain.present?

      result = @ip_address_processor.new({ ip: find_ip(domain_name) }).call

      if result.success?
        domain = Domain.create!(
          name: domain_name,
          ip_address: result.value
        )
        Result.new(true, domain)
      else
        result
      end
    end

    private

    def domain_name
      @domain_name ||= URI.parse(@url).host
    end

    def find_ip(domain)
      @find_ip ||= Resolv.getaddress domain
    end
  end
end
