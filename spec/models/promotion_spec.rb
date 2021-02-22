# frozen_string_literal: true

require 'rails_helper'

describe Promotion do
  context 'when validation' do
    it 'attributes cannot be blank' do
      promotion = described_class.new

      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em '\
                                                          'branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em'\
                                                            ' branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em'\
                                                            ' branco')
    end

    it 'code must be uniq' do
      described_class.create!(name: 'Natal', description: 'Promoção de Natal',
                              code: 'NATAL10', discount_rate: 10,
                              coupon_quantity: 100, expiration_date: '22/12/2033')
      promotion = described_class.new(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('deve ser único')
    end
  end
end
