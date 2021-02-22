require 'rails_helper'

describe ProductCategory do
  context 'validation' do
    it 'cannot be blank' do
      product_category = ProductCategory.new

      product_category.valid?

      expect(product_category.errors[:name]).to include('não pode ficar em branco')
      expect(product_category.errors[:code]).to include('não pode ficar em branco')
    end

    it 'must be unique' do
      ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      product_category = ProductCategory.new(name: 'Hospedagem', code: 'HOSP')

      product_category.valid?

      expect(product_category.errors[:name]).to include('já está em uso')
      expect(product_category.errors[:code]).to include('já está em uso')
    end
  end
end
