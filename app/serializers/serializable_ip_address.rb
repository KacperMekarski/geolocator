class SerializableIPAddress < ::JSONAPI::Serializable::Resource
  type :ip_addresses

  attributes :address

  has_one :geolocation
end
