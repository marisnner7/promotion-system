# frozen_string_literal: true

module Api
  module V1
    class CouponsController < ApiController
      before_action :set_coupon, only: %i[show burn]

      def show
        render json: @coupon.promotion, status: :ok
      end

      def burn
        @coupon.order = params.require(:order).permit(:code)[:code]
        @coupon.burn!
        render json: 'Cupom utilizado com sucesso', status: :ok
      rescue ActionController::ParameterMissing
        render json: '', status: :precondition_failed
      end

      private

      def verify_order_code
        return if params.dig(:order, :code)

        render json: '', status: :precondition_failed
      end

      def set_coupon
        @coupon = Coupon.find_by!(code: params[:code])
      rescue ActiveRecord::RecordNotFound
        render json: 'Cupom não encontrado', status: 404
      end
    end
  end
end
