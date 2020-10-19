require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいく時' do
      it "ニックネーム、メール、パスワード、本名、本名カナ、誕生日が存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    
    context '新規登録がうまくいかない時' do
      it "ニックネームが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "メールアドレスが空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "メールアドレスに@がないと登録できない" do
        @user.email = "t.yamada.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "パスワードが空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password can't be blank", "Password is invalid", "Password confirmation doesn't match Password")
      end
      it "パスワードが5文字以下だと登録できない" do
        @user.password = "1234a"
        @user.password_confirmation = "1234a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワードに英字が含まれていないと登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "パスワードに数字が含まれていないと登録できない" do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "パスワードとパスワード確認が一致しないと登録できない" do
        @user.password = "12345a"
        @user.password_confirmation = "12345b"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password = "12345a"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "password_confirmationが存在してもpasswordが空では登録できない" do
        @user.password = ""
        @user.password_confirmation = "12345a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "お名前(全角)が空だと登録できない" do
        @user.first_name = ""
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "苗字が空だと登録できない" do
        @user.first_name = "太郎"
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "名前が空だと登録できない" do
        @user.first_name = ""
        @user.last_name = "山田"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "お名前(全角)が半角だと登録できない" do
        @user.first_name = "ﾔﾏﾀﾞ"
        @user.last_name = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid", "Last name is invalid")
      end
      it "苗字が半角だと登録できない" do
        @user.first_name = "ﾔﾏﾀﾞ"
        @user.last_name = "タロウﾞ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid", "Last name is invalid")
      end
      it "名前が半角だと登録できない" do
        @user.first_name = "ヤマダ"
        @user.last_name = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it "苗字のフリガナが半角だと登録できない" do
        @user.first_name_kana = "ﾔﾏﾀﾞ"
        @user.last_name_kana = "タロウ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it "名前のフリガナが半角だと登録できない" do
        @user.first_name_kana = "ヤマダ"
        @user.last_name_kana = "ﾀﾛｳﾞ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it "苗字のフリガナが平仮名だと登録できない" do
        @user.first_name_kana = "やまだ"
        @user.last_name_kana = "タロウ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it "名前のフリガナが半角だと登録できない" do
        @user.first_name_kana = "ヤマダ"
        @user.last_name_kana = "たろうﾞ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it "生年月日が空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end