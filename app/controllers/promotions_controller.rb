class PromotionsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_promotion, only: [:show, :edit, :update, :destroy, :generate_coupons]
    def index
      @promotions = Promotion.all
      @search = params["search"]
      if @search.present?
        @name = @search["name"]
        @promotions = Promotion.where("name ILIKE ?", "%#{@name}%")
      end
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
  
  def edit
    
  end

  def update
    @promotion.update(promotion_params)
    redirect_to @promotion, notice: 'Promoção editada'
    
  end

  def destroy
    @promotion.destroy
    redirect_to promotions_path, notice: "Promoção deletada com sucesso"
  end

  def generate_coupons
    (1..@promotion.coupon_quantity).each do |number|
      code = "#{@promotion.code}-#{'%04d' % number}"
      Coupon.create!(promotion: @promotion, code: code)
    end
    flash[:success] = 'Cupons gerados com sucesso'
    # @promotion.generate_coupons!
    redirect_to @promotion

    
  end


  private

  def promotion_params
    params.permit(:promotion)    
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end
