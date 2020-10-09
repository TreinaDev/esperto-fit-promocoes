require 'rails_helper'

describe 'Coupon API' do
  context 'validation' do
    it 'successfully' do
      coupon = create(:coupon)

      get api_v1_path(coupon)

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response.content_type).to include('application/json')
      expect(response.body).to eq coupon.validation_result.to_json
      expect(body[0][:available]).to eq 'Cupom válido'
      expect(body[0][:discount_rate]).to eq '100.0'
      expect(body[0][:monthly_duration]).to eq 6
      expect(body[0][:expire_date]).to include('09/09/2024')
      expect(body[0][:promotion]).to eq 'Promoção de natal'
    end

    it 'coupon expired' do
      coupon = create(:coupon)

      travel_to Time.zone.local(2025, 10, 1, 12, 30, 45) do
        get api_v1_path(coupon)
      end

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[0][:available]).to eq 'Cupom expirado'
      expect(body[0]).not_to include('100.0')
      expect(body[0]).not_to include('Promoção de natal')
    end

    it 'coupon already consumed' do
      coupon = create(:coupon, consumed: true)

      get api_v1_path(coupon)

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[0][:available]).to eq 'Cupom já utilizado'
      expect(body[0]).not_to include('100.0')
    end
  end

  context 'token' do
    it 'not found' do
      get '/api/v1/coupons/AAAAA'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Cupom não encontrado')
    end
  end
end
