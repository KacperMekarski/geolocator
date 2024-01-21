FactoryBot.define do
  factory :geolocation, class: 'Geolocation' do
    continent_code { 'NA' }
    continent_name { 'North America' }
    country_code { FFaker::Address.country_code }
    country_name { FFaker::Address.country }
    region_code { FFaker::AddressUS.state_abbr }
    region_name { FFaker::AddressUS.state }
    city { FFaker::Address.city }
    zip { FFaker::AddressUS.zip_code }
    latitude { FFaker::Geolocation.lat }
    longitude { FFaker::Geolocation.lng }

    association :ip_address, factory: :ip_address
  end
end
