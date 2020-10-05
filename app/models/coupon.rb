class Coupon < ApplicationRecord
  belongs_to :promotion
  belongs_to :subsidiary
end
