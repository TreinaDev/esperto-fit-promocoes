class CouponsController < ApplicationController
  def new
    @promotion = Promotion.find(params[:id])
    @coupon = Coupon.new
  end
end