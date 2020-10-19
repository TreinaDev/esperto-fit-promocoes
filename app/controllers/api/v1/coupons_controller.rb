class Api::V1::CouponsController < Api::V1::ApiController
  rescue_from ActiveRecord::RecordNotFound, with: :token_not_found

  def show
    if Coupon.not_discarded.find_by(token: params[:token]).present?
      @coupon = Coupon.not_discarded.find_by(token: params[:token])
      render_coupon
    else
      @coupon = SingleCoupon.not_discarded.find_by!(token: params[:token])
      render_single_coupon
    end
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: { message: 'Cupom não encontrado' }
  end

  def burn
    localize_coupon

    @coupon.update!(status: :consumed, client_email: params[:email])
    render status: :ok
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

  def token_not_found
    render status: :precondition_failed, json: { message: 'Token inválido' }
  end

  def localize_coupon
    @coupon = if SingleCoupon.applicable.find_by(token: params[:token]).present?
                SingleCoupon.applicable.find_by!(token: params[:token])
              else
                Coupon.applicable.find_by!(token: params[:token])
              end
  end
end
