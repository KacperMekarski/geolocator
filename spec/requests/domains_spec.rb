require 'rails_helper'

describe 'Domains', type: :request do
  describe 'GET /api/domains' do
    let!(:domain) { create(:domain, ip_address: create(:ip_address, geolocation: create(:geolocation))) }
    let(:response_body) { JSON.parse(response.body) }

    shared_examples 'has valid JSON payload' do
      it 'has valid JSON payload' do
        expect(response).to have_http_status(:ok)
        expect(response_body['data']).to have_attribute(:name).with_value(domain.name)
        expect(response_body['data']).to have_relationships(:geolocation)
        expect(response_body['included']).to include(have_type('geolocations').and(have_attribute(:continent_code).with_value(domain.geolocation.continent_code)
          .and(have_attribute(:continent_name).with_value(domain.geolocation.continent_name)
          .and(have_attribute(:country_code).with_value(domain.geolocation.country_code)
          .and(have_attribute(:country_name).with_value(domain.geolocation.country_name)
          .and(have_attribute(:region_code).with_value(domain.geolocation.region_code)
          .and(have_attribute(:region_name).with_value(domain.geolocation.region_name)
          .and(have_attribute(:city).with_value(domain.geolocation.city)
          .and(have_attribute(:zip).with_value(domain.geolocation.zip)
          .and(have_attribute(:latitude).with_value(domain.geolocation.latitude)
          .and(have_attribute(:longitude).with_value(domain.geolocation.longitude))))))))))))
      end
    end

    context 'when domain exists' do
      let(:url) { "https://#{domain.name}/products?name=jacket" }

      context 'when URL is encoded' do
        before { get "/api/domains?url=#{CGI.escape(url)}", as: :json }

        it_behaves_like 'has valid JSON payload'
      end

      context 'when URL is not encoded' do
        before { get "/api/domains?url=#{url}", as: :json }

        it_behaves_like 'has valid JSON payload'
      end
    end

    context 'when domain does not exist' do
      before { get "/api/domains?url=#{FFaker::Internet.http_url}", as: :json }

      it 'renders error payload' do
        expect(response).to have_http_status(:not_found)
        expect(response_body['errors']).to include({ 'detail' => 'Not found' })
      end
    end

    context 'when URL is invalid' do
      before { get '/api/domains?url=invalid_url', as: :json }

      it 'renders error payload' do
        expect(response).to have_http_status(:not_found)
        expect(response_body['errors']).to include({ 'detail' => 'Not found' })
      end
    end
  end

  describe 'DELETE /api/domains' do
    subject { delete "/api/domains?url=#{CGI.escape(url)}", as: :json }

    let!(:domain) { create(:domain, ip_address: create(:ip_address, geolocation: create(:geolocation))) }
    let(:response_body) { JSON.parse(response.body) }

    context 'when domain is found' do
      let(:url) { "https://#{domain.name}/products?name=jacket" }

      it 'deletes domain' do
        expect { subject }.to change(Domain, :count).by(-1)
      end

      it 'has valid JSON payload' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when IP address is not found' do
      before { delete "/api/domains?url=#{CGI.escape(FFaker::Internet.http_url)}", as: :json }

      it 'renders error payload' do
        expect(response).to have_http_status(:not_found)
        expect(response_body['errors']).to include({ 'detail' => 'Not found' })
      end
    end
  end
end
