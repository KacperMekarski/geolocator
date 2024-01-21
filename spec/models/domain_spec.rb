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
    it 'belongs to internet protocol' do
      expect(build(:domain).internet_protocol).to be_present
    end
  end
end
