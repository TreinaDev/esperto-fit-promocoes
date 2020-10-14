class Api::V1::CouponsController < Api::V1::ApiController
  def show
    @coupon = Coupon.find_by!(token: params[:token])
    render json: @coupon.as_json(only: [], methods: :available,
                                 include: { promotion: { methods: :expire_date_formatted,
                                                         only: %i[discount_rate monthly_duration name] } }), status: :ok
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: { message: 'Cupom não encontrado' }
  end

  def burn
    @coupon = Coupon.applicable.find_by!(token: params[:token])
    @coupon.consumed = true
    @coupon.client_email = params[:email]
    @coupon.save
    render status: :ok
  rescue ActiveRecord::RecordNotFound
    render status: :precondition_failed, json: { message: 'Token inválido' }
  end
end
