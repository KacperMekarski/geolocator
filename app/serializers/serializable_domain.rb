class SerializableDomain < ::JSONAPI::Serializable::Resource
  type :domains

  attributes :name

  has_one :geolocation

  def jsonapi_cache_key(*)
    @object.cache_key_with_version
  end
end
