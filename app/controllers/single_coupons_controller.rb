class SingleCouponsController < ApplicationController
  before_action :set_single_coupons, only: %i[index]

  def index; end

  def show
    @single_coupon = SingleCoupon.find(params[:id])
  end

  def new
    @coupon = SingleCoupon.new
  end

  def create
    @coupon = SingleCoupon.new(single_coupon_params)
    @coupon.token.upcase!
    return redirect_to @coupon if @coupon.save

    render :new
  end

  def discard
    @single_coupon = SingleCoupon.find(params[:id])
    return render :show, notice: 'Não é possível descartar um cupom em uso' if @single_coupon.consumed?

    @single_coupon.update!(status: :discarded,
                           discard_user: current_user.social_name,
                           discard_date: Date.current)
    render :show, notice: 'Cupom descartado'
  end

  def retrieve
    @single_coupon = SingleCoupon.find(params[:id])
    @single_coupon.update!(status: :usable)
    render :show, notice: 'Cupom recuperado'
  end

  private

  def single_coupon_params
    params.require(:single_coupon)
          .permit(:token, :discount_rate, :expire_date, :monthly_duration)
  end

  def set_single_coupons
    @coupons = SingleCoupon.where(status: %i[usable discarded]).where('expire_date >= ?', Date.current)
  end
end
