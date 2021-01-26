class MultiItemDiscount < ApplicationRecord
  belongs_to :item
  validates_presence_of :upc
end
