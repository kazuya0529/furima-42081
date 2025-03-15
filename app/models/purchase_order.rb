class PurchaseOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture, :city, :addresses, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :addresses
    validates :phone_number,
              format: { with: /\A\d{10,11}\z/, message: 'is invalid. Enter a 10 or 11 digit number without hyphens' }
  end
end
