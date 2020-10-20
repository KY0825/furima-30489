class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @item.valid?
      @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image,:name,:text,:category_id,:status_id,:delivery_charge_id,:delivery_area_id,:days_id,:price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def user_check
    if current_user.id != @item.user_id
      redirect_to action: :index
    end
  end

end