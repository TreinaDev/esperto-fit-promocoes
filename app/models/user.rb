class User < ApplicationRecord
  has_one :partner_company, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
