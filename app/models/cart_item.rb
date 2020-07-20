class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food_item
  validates_uniqueness_of :food_item_id, scope: :cart_id

  def sub_total
    quantity*food_item.price
  end
  
end