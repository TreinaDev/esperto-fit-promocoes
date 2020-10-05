class Promotion < ApplicationRecord
  validates :token, uniqueness: true
  validates :token, :name, :discount_rate, :description, :coupon_quantity, :expire_date, presence: true
  validates :discount_rate, :coupon_quantity, numericality: { greater_than: 0, message: :greater_than_zero }
  validate :expire_date_must_be_future
  validates :token, length: { in: 6..10 }

  private

  def expire_date_must_be_future
    return unless expire_date.present? && expire_date < Date.current

    errors.add(:expire_date, :expire_date_must_be_future)
  end
end
