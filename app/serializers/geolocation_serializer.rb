class GeolocationSerializer < BaseSerializer
  attributes :continent_code, :continent_name, :country_code, :country_name, :region_code, :region_name, :city, :zip,
             :latitude, :longitude

  belongs_to :ip_address
end
