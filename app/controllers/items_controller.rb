class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  before_action :edit_user_item, only: :edit

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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if current_user.id != @item.user_id
      redirect_to action: :index
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.valid?
      redirect_to item_path
    else
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:image,:name,:text,:category_id,:status_id,:delivery_charge_id,:delivery_area_id,:days_id,:price).merge(user_id: current_user.id)
  end


  def edit_user_item
    unless user_signed_in?
      redirect_to action: :new
    end
  end
end