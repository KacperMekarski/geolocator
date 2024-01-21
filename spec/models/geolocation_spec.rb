require 'rails_helper'

describe Geolocation, type: :model do
  describe 'validations' do
    it 'validates presence of continent_code' do
      expect(build(:geolocation, continent_code: nil)).to be_invalid
    end

    it 'validates presence of continent_name' do
      expect(build(:geolocation, continent_name: nil)).to be_invalid
    end

    it 'validates presence of country_code' do
      expect(build(:geolocation, country_code: nil)).to be_invalid
    end

    it 'validates presence of country_name' do
      expect(build(:geolocation, country_name: nil)).to be_invalid
    end

    it 'validates presence of region_code' do
      expect(build(:geolocation, region_code: nil)).to be_invalid
    end

    it 'validates presence of region_name' do
      expect(build(:geolocation, region_name: nil)).to be_invalid
    end

    it 'validates presence of city' do
      expect(build(:geolocation, city: nil)).to be_invalid
    end

    it 'validates presence of zip' do
      expect(build(:geolocation, zip: nil)).to be_invalid
    end

    it 'validates presence of latitude' do
      expect(build(:geolocation, latitude: nil)).to be_invalid
    end

    it 'validates presence of longitude' do
      expect(build(:geolocation, longitude: nil)).to be_invalid
    end
  end

  describe 'associations' do
    it 'belongs to ip address' do
      expect(build(:geolocation).ip_address).to be_present
    end
  end
end
