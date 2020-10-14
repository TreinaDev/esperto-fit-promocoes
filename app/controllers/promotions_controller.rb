class PromotionsController < ApplicationController
  before_action :authorize_admin, only: %i[new create edit]
  before_action :set_promotion, only: %i[show edit update emission]
  before_action :verify_emitted_coupons, only: %i[edit update]
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

  def edit; end

  def update
    if @promotion.update(promotion_params)
      @promotion.token.upcase!
      @promotion.save
      redirect_to @promotion, notice: 'Promoção editada com sucesso!'
    else
      render :edit
    end
  end

  def emission
    return render status: :precondition_failed, json: 'Emissão de cupons indisponível' unless @promotion.available?

    @promotion.generate_coupons!
    redirect_to promotion_coupons_path(@promotion), notice: 'Cupons emitidos com sucesso'
  end

  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def verify_emitted_coupons
    redirect_to root_path, notice: 'Você não tem permissão para essa ação' unless @promotion.coupon_quantity != 0
  end

  def promotion_params
    params.require(:promotion)
          .permit(:name, :description, :token, :discount_rate,
                  :expire_date, :coupon_quantity, :monthly_duration)
  end
end
