FactoryBot.define do
  factory :ip_address, class: 'IPAddress' do
    address { FFaker::Internet.ip_v4_address }
  end
end
