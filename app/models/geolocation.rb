class Geolocation < ApplicationRecord
  validates :continent_code, :continent_name, :country_code,
             :country_name, :region_code, :region_name, :city, :zip, :latitude, :longitude, presence: true

  belongs_to :internet_protocol
end
