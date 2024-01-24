class IPAddressSerializer < BaseSerializer
  attributes :address

  has_one :geolocation
  has_many :domains
end
