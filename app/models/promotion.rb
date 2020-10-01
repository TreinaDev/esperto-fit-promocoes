class Promotion < ApplicationRecord
  validates :token, uniqueness: true
  before_create :generate_token

  private

  def generate_token
    self.token = "PROMO-#{SecureRandom.alphanumeric(3)}"
  end
end
