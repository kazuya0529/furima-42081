require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'ニックネームが必須であること' do
      @user.nickname = ''
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが必須であること' do
      @user.email = ''
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = User.new(email: @user.email)
      expect(another_user).not_to be_valid
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'testexample.com'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが必須であること' do
      @user.password = ''
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは6文字以上での入力が必須であること' do
      @user.password = '12345'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは半角数字のみの場合登録できない' do
      @user.password = '123456'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'パスワードは半角英字のみの場合登録できない' do
      @user.password = 'abcdef'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'パスワードに全角文字が含まれている場合登録できない' do
      @user.password = 'abcdeあ'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      @user.password_confirmation = 'different_password'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      @user.last_name = ''
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")

      @user.first_name = ''
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.last_name = 'Yamada'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Last name is invalid')

      @user.first_name = 'Taro'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('First name is invalid')
    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      @user.last_name_kana = ''
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")

      @user.first_name_kana = ''
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.last_name_kana = 'Yamada'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Last name kana is invalid')

      @user.first_name_kana = 'Taro'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('First name kana is invalid')
    end

    it '生年月日が必須であること' do
      @user.birth_date = ''
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
