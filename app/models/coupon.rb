class Coupon < ApplicationRecord
  belongs_to :promotion

  def available
    return 'Cupom expirado' if date_expired?

    return 'Cupom já utilizado' if consumed?

    'Cupom válido'
  end

  def date_expired?
    promotion.expire_date.past?
  end

  scope :applicable, lambda {
    Coupon.joins(:promotion).where('promotions.expire_date >= ?', Date.current).where(consumed: false)
  }
end
