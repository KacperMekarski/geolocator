class DomainSerializer < BaseSerializer
  attributes :name

  has_one :geolocation
  belongs_to :ip_address
end
