class IPAddress < ApplicationRecord
  validates :address, presence: true, uniqueness: { case_sensitive: false },
                      format: { with: Resolv::AddressRegex }

  has_one :geolocation, dependent: :destroy
  has_many :domains, dependent: :destroy

  accepts_nested_attributes_for :geolocation
end
