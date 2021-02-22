# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: { active: 0, inactive: 20, burn: 10 }
  delegate :expiration_date, :discount_rate, to: :promotion

  def self.search(search)
    if search 
      where(code: search)
    end
  end

  def title
    "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
  end

  def as_json(options = {})
    super({ methods: %i[discount_rate expiration_date],
            only: %i[] }.merge(options))
  end

  def burn!(order)
    raise ActiveRecord::RecordInvalid unless order.present?

    update!(order: order, status: :burn)
  end


  def valid_category?(category)
    return true if self.promotion.product_categories.count == 0 || self.promotion.product_categories.find_by(code: category)
    false
  end



end
