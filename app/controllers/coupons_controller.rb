# frozen_string_literal: true

class CouponsController < ApplicationController
  before_action :authenticate_user!

  def index
    @coupons = Coupon.search(params[:coupons_query])
  end

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
