require 'rails_helper'

describe 'Coupon API' do
  context 'single coupon validates' do
    it 'successfully' do
      single_coupon = create(:single_coupon, token: 'AVULSO123')

      get api_v1_path(single_coupon.token)

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.content_type).to include('application/json')
      expect(body[:available]).to eq 'Cupom válido'
      expect(body[:discount_rate]).to eq '20.0'
      expect(body[:monthly_duration]).to eq 0
      expect(body[:expire_date_formatted]).to include('09/09/2022')
    end

    it 'single coupon expired' do
      single_coupon = create(:single_coupon)

      travel_to Time.zone.local(2025, 10, 1, 12, 30, 45) do
        get api_v1_path(single_coupon.token)
      end

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:available]).to eq 'Cupom expirado'
      expect(body[:discount_rate]).to eq '20.0'
      expect(body[:monthly_duration]).to eq 0
      expect(body[:expire_date_formatted]).to include('09/09/2022')
    end
  end

  context 'token' do
    it 'not found' do
      get '/api/v1/coupons/AAAAA'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Cupom não encontrado')
    end

    it 'blank' do
      get api_v1_path(token: ' ')

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Cupom não encontrado')
    end
  end

  context 'burn' do
    it 'successfully' do
      single_coupon = create(:single_coupon, token: 'AVULSO123', consumed: false)

      post '/api/v1/coupon_burn', params: { token: 'AVULSO123', email: 'client1@email.com' }
      single_coupon.reload

      expect(single_coupon.consumed).to eq true
      expect(single_coupon.client_email).to eq 'client1@email.com'
      expect(response).to be_ok
    end

    it 'empty params' do
      post '/api/v1/coupon_burn', params: {}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(body[:message]).to include('Token inválido')
    end

    it 'invalid params' do
      post '/api/v1/coupon_burn', params: { token: 'AVULSO764' }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(body[:message]).to include('Token inválido')
    end

    it 'consumed coupon' do
      create(:single_coupon, token: 'AVULSO123', consumed: true)

      post '/api/v1/coupon_burn', params: { token: 'AVULSO123' }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(body[:message]).to include('Token inválido')
    end

    it 'coupon expired' do
      single_coupon = create(:single_coupon, expire_date: Date.parse('09/09/2024'))

      travel_to Time.zone.local(2025, 10, 1, 12, 30, 45) do
        post '/api/v1/coupon_burn', params: { token: single_coupon.token }
      end

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(body[:message]).to include('Token inválido')
    end
  end
end
