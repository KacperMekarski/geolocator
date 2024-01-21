FactoryBot.define do
  factory :domain, class: 'Domain' do
    name { FFaker::Internet.domain_name }

    association :internet_protocol, factory: :internet_protocol
  end
end
