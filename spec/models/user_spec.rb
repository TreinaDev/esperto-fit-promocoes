require 'rails_helper'

RSpec.describe User, type: :model do
  context 'E-mail' do
    it 'invalid domain' do
      user = build(:user, email: 'test@invalid.com.br')
      user.valid?

      expect(user.errors[:email]).to include('não é válido')
    end

    it 'contains @espertofit.com.br' do
      user = build(:user, email: 'test@espertofit.com.br')

      expect(user.save).to be_truthy
    end
  end
end
