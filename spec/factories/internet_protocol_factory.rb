FactoryBot.define do
  factory :internet_protocol,  class: InternetProtocol do
    name { FFaker::Internet.ip_v4_address }
  end
end
