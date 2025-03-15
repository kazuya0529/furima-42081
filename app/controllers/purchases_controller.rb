class PurchasesController < ApplicationController
  def index
    @purchase_order = PurchaseOrder.new
  end
end
