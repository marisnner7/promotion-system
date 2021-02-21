# frozen_string_literal: true

class ProductCategoriesController < ApplicationController
  before_action :set_product_category, only: %i[show edit update destroy]
  def index
    @product_categories = ProductCategory.all
  end

  def show; end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      redirect_to product_categories_path(@product_category)
    else
      render :new
    end
  end

  private

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  def product_category_params
    params.require(:product_category).permit(:name, :code)
  end
end
