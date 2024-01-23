class Geolocation < ApplicationRecord
  FIELDS = %w[ip continent_code continent_name country_code country_name region_code
              region_name city zip latitude longitude].freeze

  validates :continent_code, :continent_name, :country_code,
            :country_name, :region_code, :region_name, :city, :zip, :latitude, :longitude, presence: true

  belongs_to :ip_address
end
