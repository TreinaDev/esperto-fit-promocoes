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
    it 'discarded single coupon cannot appear' do
      single_coupon = create(:single_coupon, status: :discarded)

      get api_v1_path(single_coupon.token)

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include 'Cupom não encontrado'
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
end
