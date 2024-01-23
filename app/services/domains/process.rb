module Domains
  class Process
    def initialize(params)
      @ip_address = params[:ip]
    end

    def call
      ip_address = IPAddress.find_by(address: @ip_address)
      return Result.new(true, ip_address) if ip_address.present?
      return Result.new(false, nil, :unprocessable_entity) unless @ip_address =~ Resolv::AddressRegex

      result = @geolocation_adapter.call(@ip_address)

      if result.success?
        ip_address = IPAddress.create!(
          address: @ip_address,
          geolocation_attributes: result.value.except('ip')
        )
        Result.new(true, ip_address)
      else
        result
      end
    end
  end
end
