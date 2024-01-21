FactoryBot.define do
  factory :domain, class: 'Domain' do
    name { FFaker::Internet.domain_name }

    association :ip_address, factory: :ip_address
  end
end
