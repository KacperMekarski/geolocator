# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
IPAddress.delete_all
Domain.delete_all
Geolocation.delete_all

20.times do
  IPAddress.create(
    address: FFaker::Internet.ip_v4_address,
    geolocation_attributes: {
      continent_code: 'NA',
      continent_name: 'North America',
      country_code: FFaker::Address.country_code,
      country_name: FFaker::Address.country,
      region_code: FFaker::AddressUS.state_abbr,
      region_name: FFaker::AddressUS.state,
      city: FFaker::Address.city,
      zip: FFaker::AddressUS.zip_code,
      latitude: FFaker::Geolocation.lat,
      longitude: FFaker::Geolocation.lng
    }
  )

  IPAddress.limit(10).each do |ip_address|
    Domain.create(name: FFaker::Internet.domain_name, ip_address: ip_address)
  end
end
