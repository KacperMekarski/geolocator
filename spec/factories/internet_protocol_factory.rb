FactoryBot.define do
  factory :internet_protocol, class: 'InternetProtocol' do
    address { FFaker::Internet.ip_v4_address }
  end
end
