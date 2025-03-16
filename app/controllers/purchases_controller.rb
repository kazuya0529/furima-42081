class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :redirect_if_sold_out, only: [:index, :create]
  before_action :redirect_if_seller, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_order = PurchaseOrder.new
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_params)
    if @purchase_order.valid?
      pay_item
      @purchase_order.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_order).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_sold_out
    return unless @item.purchase.present? && @item.user_id != current_user.id

    redirect_to root_path
  end

  def redirect_if_seller
    return unless @item.user_id == current_user.id

    redirect_to root_path
  end
end
