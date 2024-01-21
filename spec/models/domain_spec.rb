require 'rails_helper'

describe Domain, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      expect(build(:domain, name: nil)).to be_invalid
    end

    it 'validates uniqueness of name' do
      create(:domain, name: 'example.com')
      expect(build(:domain, name: 'example.com')).to be_invalid
    end

    it 'validates case insensitivity of name' do
      create(:domain, name: 'example.com')
      expect(build(:domain, name: 'EXAMPLE.COM')).to be_invalid
    end
  end

  describe 'associations' do
    let!(:domain) { create(:domain, ip_address: create(:ip_address, geolocation: create(:geolocation))) }

    it 'belongs to ip address' do
      expect(domain.ip_address).to be_present
    end

    it 'has one geolocation through ip address' do
      expect(domain.geolocation).to be_present
    end
  end
end
