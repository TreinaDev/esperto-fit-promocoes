require 'rails_helper'

RSpec.describe User, type: :model do
  context 'E-mail' do
    it 'invalid domain' do
      user = User.new(email: 'test@invalid.com.br', password: '12345678')
      user.valid?

      expect(user.errors[:email]).to include('não é válido')
    end

    it 'contains @espertofit.com.br' do
      user = create(:user, email: 'test@espertofit.com.br')

      expect(user.save).to be_truthy
    end
  end
end
