class IPAddress < ApplicationRecord
  validates :address, presence: true, uniqueness: true

  has_one :geolocation, dependent: :destroy
  has_many :domains, dependent: :destroy
end
