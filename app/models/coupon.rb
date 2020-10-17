class Coupon < ApplicationRecord
  belongs_to :promotion
  validate :unique_token_across_promotion_single

  enum status: { usable: 0, consumed: 1, discarded: 2}

  def available
    return 'Cupom expirado' if date_expired?

    return 'Cupom já utilizado' if consumed?

    'Cupom válido'
  end

  def date_expired?
    promotion.expire_date.past?
  end

  def unique_token_across_promotion_single
    errors.add(:token, :taken) if SingleCoupon.exists?(token: token)
  end

  scope :applicable, lambda {
    Coupon.joins(:promotion).where('promotions.expire_date >= ?', Date.current).where(consumed: false)
  }
end
