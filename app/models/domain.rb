class Domain < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  belongs_to :ip_address
  has_one :geolocation, through: :ip_address
end
