# frozen_string_literal: true

class ShopsController < ApplicationController
  before_action :find_shop, only: %i[show]
  before_action :no_shop?, only: %i[new create]
  before_action :own_shop?, only: %i[edit update]
  before_action :authenticate_user!, except: %i[index show search]
  before_action :find_owned_shop, only: %i[edit update destroy]

  # 搜尋修改後
  def index
    @shop = current_user&.shop
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).order(order_by).page(params[:page])
  end

  def new
    @shop = Shop.new
    authorize @shop
  end

  def create
    @shop = current_user.build_shop(shop_params)
    authorize @shop

    if @shop.save
      redirect_to shop_path(@shop), notice: t('list_your_services_products', scope: %i[views shop message])
    else
      render :new
    end
  end

  def edit
    authorize @shop
  end

  def show
    @comments = @shop.comments.order(created_at: :desc)
  end

  def update
    if @shop.update(shop_params)
      redirect_to vendor_index_path, notice: t(:updated, scope: %i[views shop message])
    else
      render :edit
    end
  end

  def destroy; end

  def search
    @shops = Shop.ransack(title_cont: params[:q]).result.page(params[:page])
  end


  private

  def shop_params
    params.require(:shop).permit(
      :title, :tel, :description,
      :city, :district, :street,
      :contact, :contactphone,
      :cover, :status
    )
  end

  def find_shop
    @shop = Shop.find(params[:id])
  end

  def find_owned_shop
    @shop = current_user.shop
  end

  # 搜尋新增
  def order_by
    params.dig(:q, :s) || 'city desc'
  end

  def no_shop?
    current_user.shop.nil?
  end

  def own_shop?
    return false unless current_user == @shop

    redirect_to root_path, alert: t(:wrong_way, scope: %i[views shop message])
  end
end
