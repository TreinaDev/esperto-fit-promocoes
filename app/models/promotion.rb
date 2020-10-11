class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  validates :token, uniqueness: true
  validates :token, :name, :discount_rate, :description, :coupon_quantity, :expire_date, presence: true
  validates :discount_rate, :coupon_quantity, numericality: { greater_than_or_equal_to: 0, message: :greater_than_zero }
  validate :expire_date_must_be_future
  validates :token, length: { in: 6..10 }

  def generate_coupons!
    ActiveRecord::Base.transaction do
      coupon_quantity.times do |i|
        Coupon.create!(promotion_id: id, coupon_number: i + 1,
                       token: "#{token}#{(i + 1).to_s.rjust(3, '0')}")
      end
      update!(coupon_quantity: 0)
    end
  end

  def expire_date_formatted
    expire_date.strftime('%d/%m/%Y')
  end

  def available?
    !coupon_quantity.zero?
  end

  private

  def expire_date_must_be_future
    return unless expire_date.present? && expire_date < Date.current

    errors.add(:expire_date, :expire_date_must_be_future)
  end
end
