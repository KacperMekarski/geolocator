class InternetProtocol < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_one :geolocation, dependent: :destroy
  has_many :domains, dependent: :destroy
end
