# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context '#title' do
    it 'has default value' do
      promotion = create(:promotion)
      coupon = create(:coupon, code: 'NATAL10-0002', promotion: promotion)

      expect(coupon).to be_active
      expect(coupon.title).to eq('NATAL10-0002 (Active)')
    end

    it 'is active' do
      promotion = create(:promotion)
      coupon = create(:coupon, code: 'NATAL10-0002', promotion: promotion)

      expect(coupon).to be_active
      expect(coupon.title).to eq('NATAL10-0002 (Active)')
    end

    it 'is inactive' do
      coupon = Coupon.new(code: 'NATAL10-0002', status: :inactive)

      expect(coupon).to be_inactive
      expect(coupon.title).to eq('NATAL10-0002 (Inactive)')
    end

    it 'status burned' do
      coupon = Coupon.new(code: 'NATAL10-0001', status: :burn)
      expect(coupon.title).to eq('NATAL10-0001 (Burn)')
    end
  end
end
