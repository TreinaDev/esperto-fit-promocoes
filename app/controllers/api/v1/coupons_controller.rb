class Api::V1::CouponsController < Api::V1::ApiController
  def show
    @coupon = Coupon.find(params[:token])
    render json: @coupon.validation_result.to_json
  end
end

#api/vi/coupon/234ABCD