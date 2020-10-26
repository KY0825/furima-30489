class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:create, :index]
  before_action :self_order, only: [:index, :create]
  before_action :illegal_purchase,only: [:index, :create]

  def index
    @user_order = UserOrder.new
  end

  def create
    @user_order = UserOrder.new(user_order_params)
    if @user_order.valid?
      pay_item
      @user_order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def user_order_params
    params.permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :item_id, :token).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: user_order_params[:token],
        currency: 'JPY'
      )
  end

  def self_order
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def illegal_purchase
    if @item.order.present?
      redirect_to root_path
    end
  end
end