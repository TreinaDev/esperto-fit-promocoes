class SingleCoupon < ApplicationRecord
  validates :token, :discount_rate, :expire_date, :monthly_duration, presence: true
  validates :token, uniqueness: true
  validate :unique_token_across_promotion_single
  validate :expire_date_must_be_future
  validates :discount_rate, numericality: { greater_than_or_equal_to: 0, message: :greater_than_zero }
  validates :token, length: { in: 6..10 }

  enum status: { usable: 0, consumed: 1, discarded: 2}

  def date_expired?
    expire_date.past?
  end

  def expire_date_must_be_future
    return unless expire_date.present? && expire_date < Date.current

    errors.add(:expire_date, :expire_date_must_be_future)
  end

  def unique_token_across_promotion_single
    errors.add(:token, :taken) if Coupon.exists?(token: token)
  end

  def available
    return 'Cupom expirado' if date_expired?

    return 'Cupom já utilizado' if consumed?

    'Cupom válido'
  end

  def expire_date_formatted
    expire_date.strftime('%d/%m/%Y')
  end
end
