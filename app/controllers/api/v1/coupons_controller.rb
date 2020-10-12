class Api::V1::CouponsController < Api::V1::ApiController
  def show
    @coupon = Coupon.find(params[:token])
    render json: @coupon.as_json(only: [], methods: :available,
                                 include: { promotion: { methods: :expire_date_formatted,
                                                         only: %i[discount_rate monthly_duration name] } }), status: :ok
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: { message: 'Cupom não encontrado' }
  end

  def burn
    @coupon = Coupon.find_by(token: params[:token])
    return render json: { message: 'Token inválido' }, status: :precondition_failed if @coupon.blank?

    @coupon.consumed = true
    @coupon.save
    render status: :ok
  end
end
