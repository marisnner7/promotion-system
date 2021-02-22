# frozen_string_literal: true

require 'rails_helper'

describe 'Coupon management' do
  context 'when show' do
    it 'render coupon json with discount' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      get "/api/v1/coupons/#{coupon.code}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('15')
      expect(response.body).to include('2033-12-22')
    end

    it 'coupon not found' do
      get '/api/v1/coupons/ABC123'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Cupom não encontrado')
    end

    it 'coupon with expired promotion' do
      promotion = create(:promotion, expiration_date: 2.days.ago)
      coupon = Coupon.create!(promotion: promotion, code: 'NATAL10-0001')

      get '/api/v1/coupons/NATAL10-0001'
      expect(response).to have_http_status(:precondition_failed)
      expect(response.body).to include('Cupom expirado')
    end
  end

  context 'when burn' do
    it 'change coupon status' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123' } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom utilizado com sucesso')
      expect(coupon.reload).to be_burn
      expect(coupon.reload.order).to eq('ORDER123')
    end

    it 'coupon not found by code' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post '/api/v1/coupons/ABCD-0001/burn', params: { order: { code: 'ORDER123' } }

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Cupom não encontrado')
    end

    it 'order must exist' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: {}

      expect(response).to have_http_status(:precondition_failed)
    end

    it 'order must exist with empty code' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'coupon cannot be burned if category not provided' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: 1.day.from_now)
      product_category = ProductCategory.create!(
        name: 'Category 1',
        code: 'CAT-1'
      )
      promotion.product_category_ids = [product_category.id]
      promotion.save!

      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001', status: :active)

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123' } }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('Categoria inválida para cupom')
    end

    it 'coupon can be burned if category not provided and promotion not have a category' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: 1.day.from_now)

      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001', status: :active)

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123' } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom utilizado com sucesso')
    end

    it 'coupon can be burned if category provided and promotion not have a category' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: 1.day.from_now)

      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001', status: :active)

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123' }, category: 'CAT-1' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom utilizado com sucesso')
    end

    it 'coupon can be burned if category provided and promotion has a category' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: 1.day.from_now)
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001', status: :active)
      product_category = ProductCategory.create!(
        name: 'Category 1',
        code: 'CAT-1'
      )
      promotion.product_category_ids = [product_category.id]
      promotion.save!
      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123' }, category: 'CAT-1' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom utilizado com sucesso')
    end

    it 'coupon cannot be burned if invalid category provided and promotion has a category' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: 1.day.from_now)
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001', status: :active)
      product_category = ProductCategory.create!(
        name: 'Category 1',
        code: 'CAT-1'
      )
      promotion.product_category_ids = [product_category.id]
      promotion.save!
      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123' }, category: 'CAT-2' }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('Categoria inválida para cupom')
    end
  end
end
