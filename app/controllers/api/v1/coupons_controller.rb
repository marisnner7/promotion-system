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
        return render json: 'Categoria inválida para cupom', status: :bad_request unless @coupon.valid_category? params[:category]
        @coupon.burn!(params.require(:order).permit(:code)[:code])
        
        @coupon.update(order: params[:order][:code], status: :burn)
        
        render json: 'Cupom utilizado com sucesso', status: :ok
        
        rescue ActionController::ParameterMissing
          render json: '', status: :precondition_failed
        rescue ActiveRecord::RecordInvalid
          render json: '', status: 422
      end
      
      
      private
      
     
      
      def set_coupon
        @coupon = Coupon.find_by!(code: params[:code])
        rescue ActiveRecord::RecordNotFound
          render json: 'Cupom não encontrado', status: 404
      end
    end
  end
end
