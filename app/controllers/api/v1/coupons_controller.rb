class Api::V1::CouponsController < Api::V1::ApiController
  def show
    if Coupon.find_by(token: params[:token]).present?
      @coupon = Coupon.find_by(token: params[:token])
      render_coupon
    else
      @coupon = SingleCoupon.find_by!(token: params[:token])
      render_single_coupon
    end
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: { message: 'Cupom não encontrado' }
  end

  def burn
    @coupon = Coupon.applicable.find_by!(token: params[:token])
    @coupon.consumed!
    @coupon.client_email = params[:email]
    @coupon.save
    render status: :ok
  rescue ActiveRecord::RecordNotFound
    render status: :precondition_failed, json: { message: 'Token inválido' }
  end

  def render_coupon
    render json: @coupon.as_json(only: [], methods: :available,
                                 include: { promotion: { methods: :expire_date_formatted,
                                                         only: %i[discount_rate monthly_duration name] } }),
           status: :ok
  end

  def render_single_coupon
    render json: @coupon.as_json(methods: %i[available expire_date_formatted],
                                 only: %i[discount_rate monthly_duration]),
           status: :ok
  end
end
