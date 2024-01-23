class SerializableIPAddress < ::JSONAPI::Serializable::Resource
  type :ip_addresses

  attributes :address

  has_one :geolocation

  def jsonapi_cache_key(*)
    @object.cache_key_with_version
  end
end
