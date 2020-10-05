require 'rails_helper'

describe Promotion, type: :model do
  context 'Validation' do
    it 'attributes cannot be blank' do
      promotion = Promotion.new
      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:token]).to include('não pode ficar em branco')
      expect(promotion.errors[:description]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em branco')
      expect(promotion.errors[:expire_date]).to include('não pode ficar em branco')
    end

    it 'token must be unique' do
      create(:promotion, token: 'PROMONATAL')
      promotion2 = build(:promotion, token: 'PROMONATAL')
      promotion2.valid?

      expect(promotion2.errors[:token]).to include('já está em uso')
    end

    it 'discount and coupon use times cannot be negative' do
      promotion = build(:promotion, discount_rate: -5, coupon_quantity: -10)
      promotion.valid?

      expect(promotion.errors[:discount_rate]).to include('deve ser positivo')
      expect(promotion.errors[:coupon_quantity]).to include('deve ser positivo')
    end

    it 'expire date cannot be past' do
      date = Date.parse('09/09/2020')
      promotion = build(:promotion, expire_date: date)
      promotion.valid?

      expect(promotion.errors[:expire_date]).to include('precisa ser uma data futura')
    end

    context 'token must be between 6 and 10 characters' do
      it 'cannot be less than 6' do
        promotion = build(:promotion, token: 'PROMO')
        promotion.valid?

        expect(promotion.errors[:token]).to include('é muito curto (mínimo: 6 caracteres)')
      end

      it 'cannot be more than 10' do
        promotion = build(:promotion, token: 'PROMOCAONATAL25')
        promotion.valid?

        expect(promotion.errors[:token]).to include('é muito longo (máximo: 10 caracteres)')
      end
    end
  end
end
