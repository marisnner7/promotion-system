# frozen_string_literal: true

class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  belongs_to :user, class_name: 'User', foreign_key: 'creator_id', optional: true
  belongs_to :user, class_name: 'User', foreign_key: 'approver_id', optional: true
  has_many :product_category_promotions
  has_many :product_categories, through: :product_category_promotions

  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date, presence: { message: 'não pode ficar em branco' }
  validates :code, uniqueness: { message: 'deve ser único' }

  def generate_coupons!
    raise 'Cupons já foram gerados' if coupons.any?

    coupons
      .create_with(created_at: Time.zone.now, updated_at: Time.zone.now)
      .insert_all!(generate_coupons_code)
  end

  def expired?
    expiration_date < Date.current
  end

  def approved?
    approved_at?
  end

  private

  def generate_coupons_code
    (1..coupon_quantity).map do |number|
      { code: "#{code}-#{'%04d' % number}" }
    end
  end
end
