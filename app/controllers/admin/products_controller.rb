# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :basic_auth
    before_action :set_product, only: %i[show edit update destroy]
    before_action :admin?, only: :index

    def index
      @admin_products = Product.all
    end

    def new
      @product = Product.new
    end

    def show; end

    def create
      @product = Product.new(product_params)
      @product.image.attach(params[:product][:image])
      if @product.save
        # flash[:success] = '商品を登録しました'
        redirect_to admin_products_path, notice: '商品を登録しました'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        # flash[:success] = '商品情報を更新しました'
        logger.debug 'koko1'
        redirect_to admin_products_path
      else
        render :edit, status: :unprocessable_entity # status: :unprocessable_entity でエラーメッセージが表示されるようにする
      end
    end

    def destroy
      @product.destroy
      flash[:success] = '商品を削除しました'
      redirect_to admin_products_path, status: :see_other
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :image)
    end

    def admin?
      @admin = true
    end
  end
end
