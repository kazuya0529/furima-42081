class PurchasesController < ApplicationController
  def index
    @purchase_order = PurchaseOrder.new
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_params)
    if @purchase_order.valid?
      @purchase_order.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_order).permit(:postal_code, :prefecture_id, :city, :addresses, :building,
                                           :phone_number).merge(user_id: current_user.id)
  end
end
