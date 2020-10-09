class Api::V1::CouponsController < Api::V1::ApiController
  def show
    @coupon = Coupon.find(params[:token])
    render json: @coupon.validation_result
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: { message: 'Cupom não encontrado' }
  end
end
