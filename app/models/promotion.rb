class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  validates :token, uniqueness: true
  validates :token, :name, :discount_rate, :description, :coupon_quantity, :expire_date, presence: true
  validates :discount_rate, :coupon_quantity, numericality: { greater_than_or_equal_to: 0, message: :greater_than_zero }
  validate :expire_date_must_be_future
  validates :token, length: { in: 6..10 }

  def generate_coupons!
    ActiveRecord::Base.transaction do
      create_coupons
      update!(coupon_quantity: 0)
    end
  end

  def expire_date_formatted
    expire_date.strftime('%d/%m/%Y')
  end

  def available?
    !coupon_quantity.zero?
  end

  def full_token(number)
    "#{token}#{(number + 1).to_s.rjust(3, '0')}"
  end

  def token_already_exists?(token)
    SingleCoupon.exists?(token: token) || Coupon.exists?(token: token)
  end

  def create_coupons
    coupon_quantity.times do |number|
      full_token = full_token(number)
      while token_already_exists?(full_token)
        number += 1
        full_token = full_token(number)
      end
      Coupon.create!(promotion_id: id, coupon_number: number + 1, token: full_token)
    end
  end

  private

  def expire_date_must_be_future
    return unless expire_date.present? && expire_date < Date.current

    errors.add(:expire_date, :expire_date_must_be_future)
  end
end
