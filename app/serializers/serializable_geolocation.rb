class SerializableGeolocation < ::JSONAPI::Serializable::Resource
  type :geolocations

  attributes :continent_code, :continent_name, :country_code, :country_name, :region_code, :region_name, :city, :zip,
             :latitude, :longitude
end
