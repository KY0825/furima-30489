class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit]
  before_action :set_item, only: [:show,  :edit, :update]

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
  end

  def edit
    if current_user.id != @item.user_id
      redirect_to action: :index
    end
  end

  def update
    if current_user.id == @item.user_id
      @item.update(item_params)
    end
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

  def set_item
    @item = Item.find(params[:id])
  end

end