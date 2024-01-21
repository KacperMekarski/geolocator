require 'rails_helper'

describe InternetProtocol, type: :model do
  describe 'validations' do
    let(:address) { FFaker::Internet.ip_v4_address }

    it 'validates presence of name' do
      expect(build(:internet_protocol, address: nil)).to be_invalid
    end

    it 'validates uniqueness of address' do
      create(:internet_protocol, address: address)
      expect(build(:internet_protocol, address: address)).to be_invalid
    end
  end

  describe 'associations' do
    let(:internet_protocol) do
      create(:internet_protocol, geolocation: create(:geolocation), domains: create_list(:domain, 2))
    end

    it 'has one geolocation' do
      expect(internet_protocol.geolocation).to be_present
    end

    it 'has many domains' do
      expect(internet_protocol.domains).to be_present
    end
  end
end
