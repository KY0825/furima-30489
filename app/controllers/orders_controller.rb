class OrdersController < ApplicationController

  def index
  end

  def new
    @user_order = UserOrder.new
  end

  def create
    @user_order = UserOrder.create(user_order_params)
    if @user_order.valid?
      @user_order.save
      redirect to action: :index
    else
      render action: :new
    end
  end

  private

  def user_order
    params.require(:user_order).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user, :item)
  end
end