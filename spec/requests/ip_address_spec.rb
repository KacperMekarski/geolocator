require 'rails_helper'

describe 'IP Addresses', type: :request do
  shared_examples 'valid JSON payload' do
    it 'has valid JSON payload' do
      VCR.use_cassette('geolocation_fetched') do
        subject

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
  end

  describe 'GET /api/ip_addresses/:id' do
    let!(:ip_address) { create(:ip_address, geolocation: create(:geolocation)) }
    let(:response_body) { JSON.parse(response.body) }

    context 'when IP address exists' do
      subject { get "/api/ip_addresses/#{ip_address.address}", as: :json }

      it_behaves_like 'valid JSON payload'
    end

    context 'when IP address does not exist' do
      subject { get "/api/ip_addresses/#{FFaker::Internet.ip_v4_address}", as: :json }

      it 'renders error payload' do
        subject

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
      subject { delete "/api/ip_addresses/#{FFaker::Internet.ip_v4_address}", as: :json }

      it 'renders error payload' do
        subject

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

      it 'does not create new IP address' do
        subject

        expect { subject }.not_to change(IPAddress, :count)
      end

      it_behaves_like 'valid JSON payload'
    end

    context 'when IP address is invalid' do
      let(:ip) { 'wrong_ip' }

      it 'does not create IP address' do
        expect { subject }.not_to change(IPAddress, :count)
      end

      it 'renders 422 error payload' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to include({ 'detail' => 'unprocessable_entity' })
      end
    end

    context 'when IP address does not exist', vcr: true do
      let(:ip_address) { IPAddress.last }
      let(:ip) { '193.28.84.37' }

      it 'creates new IP address with associated geolocation', vcr: true do
        VCR.use_cassette('geolocation_fetched') do
          expect { subject }.to change(IPAddress, :count).by(1)
        end
      end

      it_behaves_like 'valid JSON payload'
    end

    context 'when there is problem with geolocation service' do
      let(:ip) { '193.28.84.37' }

      it 'renders 502 error payload' do
        VCR.use_cassette('geolocation_fetched') do
          stub_const('IpstackAdapter::API_URL', 'https://api.ipstack.com')
          subject

          expect(response).to have_http_status(:bad_gateway)
          expect(response_body['errors']).to include({ 'detail' => 'bad_gateway' })
        end
      end
    end

    context 'when there was a problem with request in general' do
      let(:ip) { '193.28.84.37' }

      it 'renders 502 error payload' do
        allow(Faraday).to receive(:get).and_raise(Faraday::ConnectionFailed)
        subject

        expect(response).to have_http_status(:bad_gateway)
        expect(response_body['errors']).to include({ 'detail' => 'bad_gateway' })
      end
    end
  end
end
