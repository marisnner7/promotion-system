# frozen_string_literal: true

class CouponsController < ApplicationController
  def inactivate
    @coupon = Coupon.find(params[:id])
    @coupon.inactive!
    flash[:success] = 'Cupom cancelado com sucesso'
    redirect_to @coupon.promotion
  end

  def reactivate
    @coupon = Coupon.find(params[:id])
    @coupon.active!
    flash[:success] = 'Cupom reativado com sucesso'
    redirect_to @coupon.promotion
  end
end
