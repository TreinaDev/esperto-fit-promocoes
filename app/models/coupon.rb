class Coupon < ApplicationRecord
  belongs_to :promotion

  def validation_result
    unless date_expired? || coupon_used?
      return [{ id: id, available: 'Cupom válido', discount_rate: promotion.discount_rate,
                monthly_duration: promotion.monthly_duration,
                expire_date: promotion.expire_date.strftime('%d/%m/%Y'),
                promotion: promotion.name }]
    end

    return [{ available: 'Cupom expirado' }] if date_expired?

    [{ available: 'Cupom já utilizado' }]
  end

  def date_expired?
    promotion.expire_date.past?
  end

  def coupon_used?
    consumed?
  end
end
