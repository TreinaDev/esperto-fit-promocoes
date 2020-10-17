class CouponsController < ApplicationController
  def index
    @promotion = Promotion.find(params[:promotion_id])
    @coupons = @promotion.coupons
  end
  def discard
    @promotion = Promotion.find(params[:promotion_id])
    @coupons = @promotion.coupons
    @coupon = Coupon.find(params[:id])
    @coupon.update!(status: :discarded)
    render :index, notice: 'Descartado'
  end
end
