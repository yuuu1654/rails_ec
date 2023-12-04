# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :admin?, only: %i[index show]
  before_action :current_cart, only: %i[index show]
  def index
    @products = Product.all
  end

  def show
    @related_products = Product.all.order('created_at desc').limit(4)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def admin?
    @admin = false
  end
end
