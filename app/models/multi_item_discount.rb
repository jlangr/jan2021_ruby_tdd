class MultiItemDiscount < ApplicationRecord
  validates_presence_of :upc, :discount_at_required
  validates_numericality_of :discount_at_required, only_integer: true
 # validates :required_for_discount, 
 #   numericality: { only_integer: true, less_than: 5 }

  def price(items)
    puts "\nPRICING #{upc} #{required_for_discount}"
    item_count = 0
#    items.filter {| item | item[:upc] 
    items.map do | item |
      item_count += 1
      puts "type: #{required_for_discount.class}"
      puts "item_count #{item_count} == required_for_discount #{required_for_discount} ? #{item_count == required_for_discount}"

      if item_count == required_for_discount
        puts "EQ!!!"
        item.merge(rendered_price: 0.0)
      else
        puts "NOT EQ!!!"
        item.merge(rendered_price: item[:price])
      end
    end
  end
end
