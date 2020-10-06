class PromotionsController < ApplicationController
  before_action :authorize_admin, only: %i[new create]
  before_action :set_promotion, only: %i[show emission]
  def index
    @promotions = Promotion.all
  end

  def show; end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    @promotion.token.upcase!
    return redirect_to @promotion, notice: 'Promoção cadastrada com sucesso!' if @promotion.save

    render :new
  end

  def emission
    return render status: :precondition_failed, json: 'Emissão de cupons indisponível' if @available

    @coupons = []
    (1..@promotion.coupon_quantity).each do |i|
      @coupons << Coupon.create!(promotion_id: @promotion.id, coupon_number: i,
                                 use_counter: 1, token: "#{@promotion.token}#{i.to_s.rjust(3, '0')}")
    end
    @promotion.update!(coupon_quantity: (@promotion.coupon_quantity - @coupons.length))
    redirect_to promotion_coupons_path(@promotion), notice: 'Cupons emitidos com sucesso'
  end

  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
    @available = @promotion.coupon_quantity.zero?
  end

  def promotion_params
    params.require(:promotion)
          .permit(:name, :description, :token, :discount_rate, :expire_date, :coupon_quantity)
  end
end
