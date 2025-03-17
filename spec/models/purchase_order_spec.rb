require 'rails_helper'

RSpec.describe PurchaseOrder, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_order = FactoryBot.build(:purchase_order, user_id: @user.id, item_id: @item.id)
  end

  describe '購入情報の保存' do
    context '購入できる場合' do
      it 'すべての情報が正しく入力されていれば保存できる' do
        expect(@purchase_order).to be_valid
      end
      it '建物名が空でも保存できる' do
        @purchase_order.building = ''
        expect(@purchase_order).to be_valid
      end
    end

    context '購入できない場合' do
      it 'user_idが空だと保存できない' do
        @purchase_order.user_id = nil
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと保存できない' do
        @purchase_order.item_id = nil
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが空だと保存できない' do
        @purchase_order.postal_code = ''
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが「3桁-4桁」の形式でないと保存できない' do
        @purchase_order.postal_code = '1234567'
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefecture_idが0（未選択）だと保存できない' do
        @purchase_order.prefecture_id = 0
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できない' do
        @purchase_order.city = ''
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("City can't be blank")
      end

      it 'addressesが空だと保存できない' do
        @purchase_order.addresses = ''
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Addresses can't be blank")
      end

      it 'phone_numberが空だと保存できない' do
        @purchase_order.phone_number = ''
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下では保存できない' do
        @purchase_order.phone_number = '123456789'
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include('Phone number is invalid. Enter a 10 or 11 digit number without hyphens')
      end

      it 'phone_numberが12桁以上では保存できない' do
        @purchase_order.phone_number = '123456789012'
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include('Phone number is invalid. Enter a 10 or 11 digit number without hyphens')
      end

      it 'phone_numberにハイフンが含まれていると保存できない' do
        @purchase_order.phone_number = '090-1234-5678'
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include('Phone number is invalid. Enter a 10 or 11 digit number without hyphens')
      end

      it 'tokenが空だと保存できない' do
        @purchase_order.token = ''
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
