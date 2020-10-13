require 'rails_helper'

describe SingleCoupon, type: :model do
  context 'Validation' do
    it 'attributes cannot be blank' do
      coupon = SingleCoupon.new
      coupon.valid?

      expect(coupon.errors[:token]).to include('não pode ficar em branco')
      expect(coupon.errors[:discount_rate]).to include('não pode ficar em branco')
      expect(coupon.errors[:expire_date]).to include('não pode ficar em branco')
    end

    it 'token must be unique' do
      create(:single_coupon, token: 'PROMONATAL')
      coupon2 = build(:single_coupon, token: 'PROMONATAL')
      coupon2.valid?

      expect(coupon2.errors[:token]).to include('já está em uso')
    end

    it 'token must be unique among promotion coupons' do
      create(:coupon, token: 'IGUAL10')
      coupon2 = build(:single_coupon, token: 'IGUAL10')
      coupon2.valid?

      expect(coupon2.errors[:token]).to include('já está em uso')
    end

    it 'discount cannot be negative' do
      coupon = build(:single_coupon, discount_rate: -5)
      coupon.valid?

      expect(coupon.errors[:discount_rate]).to include('deve ser positivo')
    end

    it 'expire date cannot be past' do
      date = Date.parse('09/09/2020')
      coupon = build(:single_coupon, expire_date: date)
      coupon.valid?

      expect(coupon.errors[:expire_date]).to include('precisa ser uma data futura')
    end

    context 'token must be between 6 and 10 characters' do
      it 'cannot be less than 6' do
        coupon = build(:single_coupon, token: 'PROMO')
        coupon.valid?

        expect(coupon.errors[:token]).to include('é muito curto (mínimo: 6 caracteres)')
      end

      it 'cannot be more than 10' do
        coupon = build(:single_coupon, token: 'PROMOCAONATAL25')
        coupon.valid?

        expect(coupon.errors[:token]).to include('é muito longo (máximo: 10 caracteres)')
      end
    end
  end
end
