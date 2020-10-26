require 'rails_helper'
RSpec.describe UserOrder, type: :model do
  before do
    buyer = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @user_order = FactoryBot.build(:user_order ,item_id: item.id, user_id: buyer.id )
  end

  describe '購入機能' do
    context '購入がうまくできる時' do
      it "郵便番号、都道府県、市区町村、番地、建物名、電話番号が存在すれば登録できる" do
        expect(@user_order).to be_valid
      end
    end
    
    context '購入ができない時' do
      it "トークンが空だと登録できない" do
        @user_order.token = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Token can't be blank")
      end
      it "郵便番号が空だと登録できない" do
        @user_order.postal_code = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code can't be blank")
      end
      it "郵便番号が数字だけだと登録できない" do
        @user_order.postal_code = 1111111
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code is invalid")
      end
      it "郵便番号が全角だと登録できない" do
        @user_order.postal_code = "１１１-１１１１"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code is invalid")
      end
      it "郵便番号が6桁だと登録できない" do
        @user_order.postal_code = 111-111
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code is invalid")
      end
      it "郵便番号が8桁だと登録できない" do
        @user_order.postal_code = 1111-1111
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code is invalid")
      end
      it "都道府県で1を選ぶと登録できない" do
        @user_order.prefecture_id = 1
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it "市区町村が空だと登録できない" do
        @user_order.city = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("City can't be blank")
      end
      it "番地が空だと登録できない" do
        @user_order.address = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Address can't be blank")
      end
      it "電話番号が空だと登録できない" do
        @user_order.phone_number = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number can't be blank")
      end
      it "電話番号が全角だと登録できない" do
        @user_order.phone_number = "０９０１２３４１２３４"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number is invalid")
      end
      it "電話番号が12桁だと登録できない" do
        @user_order.phone_number = "090123412345"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number is invalid")
      end
      it "電話番号が10桁だと登録できない" do
        @user_order.phone_number = "0901234123"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number is invalid")
      end
      it "電話番号に-があると登録できない" do
        @user_order.phone_number = "090-1234-1234"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end