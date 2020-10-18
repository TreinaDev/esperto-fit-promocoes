require 'rails_helper'

describe 'Coupon API' do
  context 'validation' do
    it 'successfully' do
      coupon = create(:coupon, token: 'PROMONIVER001')

      get api_v1_path(coupon.token)

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.content_type).to include('application/json')
      expect(body[:available]).to eq 'Cupom válido'
      expect(body[:promotion][:discount_rate]).to eq '100.0'
      expect(body[:promotion][:monthly_duration]).to eq 6
      expect(body[:promotion][:expire_date_formatted]).to include('09/09/2024')
      expect(body[:promotion][:name]).to eq 'Promoção de natal'
    end

    it 'coupon expired' do
      coupon = create(:coupon)

      travel_to Time.zone.local(2025, 10, 1, 12, 30, 45) do
        get api_v1_path(coupon.token)
      end

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:available]).to eq 'Cupom expirado'
      expect(body[:promotion][:discount_rate]).to eq('100.0')
    end

    it 'coupon already consumed' do
      coupon = create(:coupon, status: :consumed)

      get api_v1_path(coupon.token)

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:available]).to eq 'Cupom já utilizado'
      expect(body[:promotion][:discount_rate]).to eq('100.0')
    end

    it 'coupon discarded cannot appear' do
      coupon = create(:coupon, status: :discarded)

      get api_v1_path(coupon.token)

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

  context 'burn' do
    it 'succesfully' do
      coupon = create(:coupon, token: 'PROMONAT001', status: :usable)

      post '/api/v1/coupon_burn', params: { token: 'PROMONAT001', email: 'client1@email.com' }
      coupon.reload

      expect(coupon.consumed?).to eq true
      expect(coupon.client_email).to eq 'client1@email.com'
      expect(response).to be_ok
    end

    it 'empty params' do
      post '/api/v1/coupon_burn', params: {}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(body[:message]).to include('Token inválido')
    end

    it 'invalid params' do
      post '/api/v1/coupon_burn', params: { token: 'PROMOBF001' }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(body[:message]).to include('Token inválido')
    end

    it 'consumed coupon' do
      create(:coupon, token: 'PROMONAT001', status: :consumed)

      post '/api/v1/coupon_burn', params: { token: 'PROMONAT001' }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(body[:message]).to include('Token inválido')
    end

    it 'coupon expired' do
      promotion = create(:promotion, expire_date: Date.parse('09/09/2024'))
      coupon = create(:coupon, promotion: promotion)

      travel_to Time.zone.local(2025, 10, 1, 12, 30, 45) do
        post '/api/v1/coupon_burn', params: { token: coupon.token }
      end

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(body[:message]).to include('Token inválido')
    end
  end
end
