class Coupon < ApplicationRecord
  belongs_to :promotion

  def validation_result
    return [{ available: 'Cupom expirado' }] if date_expired?

    return [{ available: 'Cupom já utilizado' }] if consumed?

    [{ id: id, available: 'Cupom válido', discount_rate: promotion.discount_rate,
       monthly_duration: promotion.monthly_duration,
       expire_date: promotion.expire_date.strftime('%d/%m/%Y'),
       promotion: promotion.name }]
  end

  def date_expired?
    promotion.expire_date.past?
  end
end
