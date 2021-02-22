# frozen_string_literal: true

require 'rails_helper'

describe ProductCategory do
  context 'when validation' do
    it 'cannot be blank' do
      product_category = described_class.new

      product_category.valid?

      expect(product_category.errors[:name]).to include('não pode ficar em branco')
      expect(product_category.errors[:code]).to include('não pode ficar em branco')
    end

    it 'must be unique' do
      described_class.create!(name: 'Hospedagem', code: 'HOSP')
      product_category = described_class.new(name: 'Hospedagem', code: 'HOSP')

      product_category.valid?

      expect(product_category.errors[:name]).to include('já está em uso')
      expect(product_category.errors[:code]).to include('já está em uso')
    end
  end
end
