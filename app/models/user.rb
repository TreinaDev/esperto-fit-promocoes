class User < ApplicationRecord
  validate :valid_email?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def valid_email?
    errors.add(:email, 'de registro inválido') unless email.split('@').last == 'espertofit.com.br'
  end
end
