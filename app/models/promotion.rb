class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy

  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date, presence: { message: "não pode ficar em branco" }
  validates :code, uniqueness: { message: "deve ser único" }
  
  
  def generate_coupons!
    raise 'Cupons já foram gerados' if coupons.any?

    coupons
      .create_with(created_at: Time.now, updated_at: Time.now)
      .insert_all!(generate_coupons_code)
  end

  private

  def generate_coupons_code
    (1..coupon_quantity).map do |number|
      { code: "#{code}-#{'%04d' % number}" }
    end
  end
end
