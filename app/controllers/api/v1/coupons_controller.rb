# frozen_string_literal: true

module Api
  module V1
    class CouponsController < ApiController
      before_action :set_coupon, only: %i[show burn]

      def show
        if @coupon.promotion.expired?
          render json: 'Cupom expirado', status: :precondition_failed
        else
          render json: @coupon.promotion, status: :ok
        end
      end

      def burn
        @coupon.order = params.require(:order).permit(:code)[:code]
        unless @coupon.valid_category? params[:category]
          return render json: 'Categoria inválida para cupom',
                        status: :bad_request
        end

        @coupon.burn!(params.require(:order).permit(:code)[:code])

        @coupon.update(order: params[:order][:code], status: :burn)

        render json: 'Cupom utilizado com sucesso', status: :ok
      rescue ActionController::ParameterMissing
        render json: '', status: :precondition_failed
      rescue ActiveRecord::RecordInvalid
        render json: '', status: :unprocessable_entity
      end

      private

      def set_coupon
        @coupon = Coupon.find_by!(code: params[:code])
      rescue ActiveRecord::RecordNotFound
        render json: 'Cupom não encontrado', status: :not_found
      end
    end
  end
end
