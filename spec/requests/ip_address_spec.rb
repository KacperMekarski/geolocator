require 'rails_helper'

describe 'IP Addresses', type: :request do
  shared_examples 'valid JSON payload' do
    it 'has valid JSON payload' do
      expect(response).to have_http_status(:ok)
      expect(response_body['data']).to have_attribute(:address).with_value(ip_address.address)
      expect(response_body['data']).to have_relationships(:geolocation)
      expect(response_body['included']).to include(have_type('geolocations').and(have_attribute(:continent_code).with_value(ip_address.geolocation.continent_code)
        .and(have_attribute(:continent_name).with_value(ip_address.geolocation.continent_name)
        .and(have_attribute(:country_code).with_value(ip_address.geolocation.country_code)
        .and(have_attribute(:country_name).with_value(ip_address.geolocation.country_name)
        .and(have_attribute(:region_code).with_value(ip_address.geolocation.region_code)
        .and(have_attribute(:region_name).with_value(ip_address.geolocation.region_name)
        .and(have_attribute(:city).with_value(ip_address.geolocation.city)
        .and(have_attribute(:zip).with_value(ip_address.geolocation.zip)
        .and(have_attribute(:latitude).with_value(ip_address.geolocation.latitude)
        .and(have_attribute(:longitude).with_value(ip_address.geolocation.longitude))))))))))))
    end
  end

  describe 'GET /api/ip_addresses/:id' do
    let!(:ip_address) { create(:ip_address, geolocation: create(:geolocation)) }
    let(:response_body) { JSON.parse(response.body) }

    context 'when IP address exists' do
      before { get "/api/ip_addresses/#{ip_address.address}", as: :json }

      it_behaves_like 'valid JSON payload'
    end

    context 'when IP address does not exist' do
      before { get "/api/ip_addresses/#{FFaker::Internet.ip_v4_address}", as: :json }

      it 'renders error payload' do
        expect(response).to have_http_status(:not_found)
        expect(response_body['errors']).to include({ 'detail' => 'Not found' })
      end
    end
  end

  describe 'DELETE /api/ip_addresses/:id' do
    subject { delete "/api/ip_addresses/#{ip_address.address}", as: :json }

    let!(:ip_address) { create(:ip_address, geolocation: create(:geolocation)) }
    let(:response_body) { JSON.parse(response.body) }

    context 'when IP address is found' do
      it 'deletes IP address' do
        expect { subject }.to change(IPAddress, :count).by(-1)
      end

      it 'has valid JSON payload' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when IP address is not found' do
      before { delete "/api/ip_addresses/#{FFaker::Internet.ip_v4_address}", as: :json }

      it 'renders error payload' do
        expect(response).to have_http_status(:not_found)
        expect(response_body['errors']).to include({ 'detail' => 'Not found' })
      end
    end
  end

  describe 'POST /api/ip_addresses' do
    subject { post '/api/ip_addresses', params: { ip: ip }, as: :json }

    let(:ip_address) { create(:ip_address, geolocation: create(:geolocation)) }
    let(:response_body) { JSON.parse(response.body) }

    context 'when IP address already exists' do
      let(:ip) { ip_address.address }

      before { subject }

      it 'does not create new IP address' do
        expect { subject }.not_to change(IPAddress, :count)
      end

      it_behaves_like 'valid JSON payload'
    end

    context 'when IP address is invalid' do
      let(:ip) { 'wrong_ip' }

      it 'does not create IP address' do
        expect { subject }.not_to change(IPAddress, :count)
      end

      it 'renders error payload' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to include({ 'detail' => 'unprocessable_entity' })
      end
    end

    context 'when IP address does not exist', vcr: true do
      let(:ip) { '193.28.84.37' }

      it 'creates new IP address with associated geolocation', vcr: true do
        VCR.use_cassette('geolocation_fetched') do
          expect { subject }.to change(IPAddress, :count).from(0).to(1)
        end
      end
    end
  end
end
