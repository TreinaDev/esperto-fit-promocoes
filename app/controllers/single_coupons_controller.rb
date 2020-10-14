class SingleCouponsController < ApplicationController
  def index
    @coupons = SingleCoupon.where(consumed: false).where('expire_date >= ?', Date.current)
  end

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

  private

  def single_coupon_params
    params.require(:single_coupon)
          .permit(:token, :discount_rate, :expire_date, :monthly_duration)
  end
end
