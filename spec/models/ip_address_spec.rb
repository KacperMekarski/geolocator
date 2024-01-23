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

    it 'validates format of address' do
      expect(build(:ip_address, address: 'invalid')).to be_invalid
      expect(build(:ip_address, address: FFaker::Internet.ip_v4_address)).to be_valid
      expect(build(:ip_address, address: '2001:0db8:85a3:0000:0000:8a2e:0370:7334')).to be_valid
    end
  end

  describe 'associations' do
    let!(:ip_address) do
      create(:ip_address, geolocation: create(:geolocation), domains: create_list(:domain, 2))
    end

    it 'has one geolocation' do
      expect(ip_address.geolocation).to be_present
    end

    it 'deletes geolocation when IP address is deleted' do
      expect { ip_address.destroy }.to change(Geolocation, :count).by(-1)
    end

    it 'deletes domains when IP address is deleted' do
      expect { ip_address.destroy }.to change(Domain, :count).by(-2)
    end

    it 'has many domains' do
      expect(ip_address.domains).to be_present
    end
  end
end
