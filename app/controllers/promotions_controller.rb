class PromotionsController < ApplicationController
  before_action :authorize_admin, only: %i[new create]
  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    @promotion.token.upcase!
    return redirect_to @promotion, notice: 'Promoção cadastrada com sucesso!' if @promotion.save

    render :new
  end

  private

  def promotion_params
    params.require(:promotion)
          .permit(:name, :description, :token, :discount_rate, :expire_date, :coupon_quantity)
  end
end
