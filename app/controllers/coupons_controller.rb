class CouponsController < ApplicationController
  def index
    @promotion = Promotion.find(params[:promotion_id])
    @coupons = Coupon.where(promotion_id: @promotion)
  end
end
