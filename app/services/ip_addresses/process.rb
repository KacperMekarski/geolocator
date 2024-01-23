module IPAddresses
  class Process < BaseService
    def initialize(params, geolocation_adapter = IpstackAdapter)
      @ip_address = params[:ip]
      @geolocation_adapter = geolocation_adapter
    end

    def call
      ip_address = IPAddress.find_by(address: @ip_address)
      return Result.new(true, ip_address) if ip_address.present?
      return Result.new(false, nil, :unprocessable_entity) unless @ip_address =~ Resolv::AddressRegex

      @geolocation_params = @geolocation_adapter.call(@ip_address)
      ip_address = IPAddress.create!(
        address: @ip_address,
        geolocation_attributes: @geolocation_params.except('ip')
      )

      Result.new(true, ip_address)
    end
  end
end
