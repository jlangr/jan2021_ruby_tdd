class MultiItemDiscount < ApplicationRecord
  validates_presence_of :upc
  belongs_to :item

  def price_last(items)
    item_price = Item.find_by(upc: upc)[:price]
    count = items.filter {| item | item[:upc] == upc }.size
    rendered_price = (count % required_for_discount == 0) ? 0.0 : item_price
    items.last.merge({price: item_price, rendered_price: rendered_price})
  end
end
