require 'rails_helper'

describe IPAddress, type: :model do
  describe 'validations' do
    let(:address) { FFaker::Internet.ip_v4_address }

    it 'validates presence of name' do
      expect(build(:ip_address, address: nil)).to be_invalid
    end

    it 'validates uniqueness of address' do
      create(:ip_address, address: address)
      expect(build(:ip_address, address: address)).to be_invalid
    end
  end

  describe 'associations' do
    let(:ip_address) do
      create(:ip_address, geolocation: create(:geolocation), domains: create_list(:domain, 2))
    end

    it 'has one geolocation' do
      expect(ip_address.geolocation).to be_present
    end

    it 'has many domains' do
      expect(ip_address.domains).to be_present
    end
  end
end
