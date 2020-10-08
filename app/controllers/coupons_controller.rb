class CouponsController < ApplicationController
  def index
    @promotion = Promotion.find(params[:promotion_id])
    @coupons = @promotion.coupons
  end
end
