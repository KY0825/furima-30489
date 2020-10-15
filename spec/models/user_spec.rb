require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいく時' do
      it "ニックネーム、メール、パスワード、本名、本名カナ、誕生日が存在すれば登録できる"
        expect(@user).to be_valid?
      end
      it "ニックネームが存在すれば登録できる" do
        @user.nickname = "やーまだ"
        expect(@user).to be_valid?
      end
      it "アドレスが存在すれば登録できる" do
        @user.email = "t.yamada@gmail.com"
        expect(@user).to be_valid?
      end
      it "パスワードとパスワード確認が存在し、かつ、一致すれば登録できる" do
        @user.password = "123456a"
        @user.password_confirmation = "123456a"
        expect(@user).to be_valid?
      end
      it "本名が存在すれば登録できる" do
        @user.first_name = "山田"
        @user.last_name = "太郎"
        expect(@user).to be_valid?
      end
      it "本名カナ（全角）が存在すれば登録できる" do
        @user.first_name_kana = "ヤマダ"
        @user.last_name_kana = タロウ
        expect(@user).to be_valid?
      end
      it "誕生日が存在すれば登録できる" do
        @user.birthday = "1991年８月25日"
        expect(@user).to be_valid?
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
        expect(@user.errors.full_messages).to include("password can't be blank")
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
        expect(@user.errors.full_messages).to include("Password need alphabet")
      end
      it "パスワードに数字が含まれていないと登録できない" do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password need number")
      end
      it "パスワードとパスワード確認が一致しないと登録できない" do
        @user.password = "12345a"
        @user.password_confirmation = "12345b"
        @user.valid?
        expect(@user.errors.full_masseges).to include("Password confirmation doesn't mutch password")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password = "12345a"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_masseges).to include("Password confirmation can't be blank")
      end
      it "password_confirmationが存在してもpasswordが空では登録できない" do
        @user.password = ""
        @user.password_confirmation = "12345a"
        @user.valid?
        expect(@user.errors.full_masseges).to include("Password can't be blank")
      end
      it "お名前(全角)が空だと登録できない" do
        @user.first_name = ""
        @user.last_name = ""
        @user.valid?
      expect(@user.errors.full_masseges).to include("User Name can't be blank")
      it "苗字が空だと登録できない" do
        @user.first_name = "太郎"
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_masseges).to include("Last Name can't be blank")
      end
      it "名前が空だと登録できない" do
        @user.first_name = ""
        @user.last_name = "山田"
        @user.valid?
        expect(@user.errors.full_masseges).to include("First Name can't be blank")
      end
      it "お名前(全角)が半角だと登録できない" do
        @user.first_name = "ﾔﾏﾀﾞ"
        @user.last_name = "ﾀﾛｳ"
        @user.valid?
      expect(@user.errors.full_masseges).to include("User Name can't be Half size")
      it "苗字が半角だと登録できない" do
        @user.first_name = "ﾔﾏﾀﾞ"
        @user.last_name = "タロウﾞ"
        @user.valid?
        expect(@user.errors.full_masseges).to include("Last Name can't be Half size")
      end
      it "名前が半角だと登録できない" do
        @user.first_name = "ヤマダ"
        @user.last_name = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_masseges).to include("First Name can't be Half size")
      end
      it "苗字のフリガナが半角だと登録できない" do
        @user.first_name_kana = "ﾔﾏﾀﾞ"
        @user.last_name_kana = "タロウ"
        @user.valid?
        expect(@user.errors.full_masseges).to include("Last Name can't be Half size")
      end
      it "名前のフリガナが半角だと登録できない" do
        @user.first_name_kana = "ヤマダ"
        @user.last_name_kana = "ﾀﾛｳﾞ"
        @user.valid?
        expect(@user.errors.full_masseges).to include("First Name can't be Half size")
      end
      it "苗字のフリガナが平仮名だと登録できない" do
        @user.first_name_kana = "やまだ"
        @user.last_name_kana = "タロウ"
        @user.valid?
        expect(@user.errors.full_masseges).to include("Last Name can't be Hiragana")
      end
      it "名前のフリガナが半角だと登録できない" do
        @user.first_name_kana = "ヤマダ"
        @user.last_name_kana = "たろうﾞ"
        @user.valid?
        expect(@user.errors.full_masseges).to include("First Name can't be Hiragana")
      end
      it "生年月日が空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_masseges).to include("Birthday can't be blank")
      end
    end
  end
end
