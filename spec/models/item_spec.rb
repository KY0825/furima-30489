require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品機能' do
    context '新規出品がうまくいく時' do
      it "商品画像、商品名、商品説明、カテゴリー、商品の状態、配送料の負担、発送元の地域、、発送までの日数、価格が存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end
    
    context '新規出品がうまくいかない時' do
      it "商品名が空だと登録できない" do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "画像が空だと登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "カテゴリーが空だと登録できない" do
        @item.category = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "カテゴリーが1だと登録できない" do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "商品の状態が空だと登録できない" do
        @item.status = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it "商品の状態が1だと登録できない" do
        @item.status_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end
      it "配送料の負担が空だと登録できない" do
        @item.delivery_charge = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank", "Delivery charge is not a number")
      end
      it "配送料の負担が1だと登録できない" do
        @item.delivery_charge_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge must be other than 1")
      end
      it "発送元の地域が空だと登録できない" do
        @item.delivery_area = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery area can't be blank", "Delivery area is not a number")
      end
      it "発送元の地域が1だと登録できない" do
        @item.delivery_area_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery area must be other than 1")
      end
      it "発送までの日数が空だと登録できない" do
        @item.days = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Days can't be blank")
      end
      it "発送までの日数が1だと登録できない" do
        @item.days_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Days must be other than 1")
      end
      it "価格が空だと登録できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number", "Price is invalid")
      end
      it "価格が300円未満だと登録できない" do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it "価格が全角だと登録できない" do
        @item.price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "価格が9,999,999円を超過すると登録できない" do
        @item.price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end