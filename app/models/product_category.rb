# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_many :product_category_promotions, dependent: :delete_all
  has_many :promotions, through: :product_category_promotions

  validates :name, :code, presence: { message: 'não pode ficar em branco' }
  validates :name, :code, uniqueness: { message: 'já está em uso' }
end
