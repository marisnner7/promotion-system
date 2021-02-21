# frozen_string_literal: true

class PromotionsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_promotion, only: %i[show edit update destroy generate_coupons]
  def index
    @promotions = Promotion.all
    @search = params['search']
    if @search.present?
      @name = @search['name']
      @promotions = Promotion.where('name ILIKE ?', "%#{@name}%")
    end
  end

  def show; end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.create(promotion_params)
    @promotion.creator_id = User.find(current_user.id).id

    if @promotion.save
      redirect_to promotions_path(@promotion)
    else
      render :new
    end
  end

  def edit; end

  def update
    @promotion.update(promotion_params)
    redirect_to promotion_path, notice: 'Promoção editada'
  end

  def destroy
    @promotion.destroy
    redirect_to promotions_path, notice: 'Promoção deletada com sucesso'
  end

  def generate_coupons
    @promotion.generate_coupons!
    flash[:success] = 'Cupons gerados com sucesso'
    redirect_to @promotion
  end

  def approve
    @promotion = Promotion.find(params[:id])
    @promotion.update(approver_id: current_user.id, approved_at: Time.now)

    redirect_to promotion_path(@promotion)
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name, :description, :code, :discount_rate, :coupon_quantity,
                                      :expiration_date, product_category_ids: [])
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end
