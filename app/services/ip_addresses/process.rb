module IPAddresses
  class Process < BaseService
    def initialize(params, geolocation_adapter = IpstackAdapter)
      @ip_address = params[:ip]
      @geolocation_adapter = geolocation_adapter
    end

    def call
      return Result.new(false, nil, :unprocessable_entity) unless Resolv::AddressRegex.match?(@ip_address)

      ip_address = IPAddress.find_by(address: @ip_address)
      return Result.new(true, ip_address) if ip_address.present?

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
