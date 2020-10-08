class Coupon < ApplicationRecord
  belongs_to :promotion

  def validation_result
   { id: id, available: 'Cupom válido', discount_rate: promotion.discount_rate, monthly_duration: promotion.monthly_duration, expire_date: promotion.expire_date.strftime("%d/%m/%Y"), promotion: promotion.name }
  end

  def date_valid?
    promotion.expire_date 
  end
end
