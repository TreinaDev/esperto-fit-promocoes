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
      expect(body[:available]).to eq 'Cupom válido'
      expect(body[:discount_rate]).to eq '100.0'
      expect(body[:monthly_duration]).to eq 6
      expect(body[:expire_date]).to include('09/09/2024')
      expect(body[:promotion]).to eq 'Promoção de natal'
      
    end
  end
end

#body = JSON.parse(response.body, symbolize_names: true)
#expect(body[0][:license_plate]).to eq('ABC1234')

#render { id: 10, value: 50, status: “available” }.to_json

# desconto
# numero de parcelas de aplicação
# valido ou nao - data e se já foi usado ou não