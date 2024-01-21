class SerializableDomain < ::JSONAPI::Serializable::Resource
  type :domains

  attributes :name

  has_one :geolocation
end
