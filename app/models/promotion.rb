class Promotion < ApplicationRecord
  validates :token, uniqueness: true
  validates :token, :name, :discount_rate, :description, :coupon_quantity, :expire_date, presence: true
  validates :discount_rate, :coupon_quantity, numericality: { greater_than: 0, message: 'deve ser positivo' }
  validate :expire_date_must_be_future

  private

  def expire_date_must_be_future
    return unless expire_date.present? && expire_date < Date.current

    errors.add(:expire_date, 'precisa ser uma data futura')
  end
end
