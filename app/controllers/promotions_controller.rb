class PromotionsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_promotion, only: [:show, :edit, :update, :destroy]
  def index
    @promotions = Promotion.all
  end

  def show
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to promotions_path(@promotion)
    else
      render :new
    end
  end

  private

  def promotion_params
  params.require(:promotion).permit(:name, :description, :code, :discount_rate, :coupon_quantity, :expiration_date)    
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end
