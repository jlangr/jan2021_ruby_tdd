class CreateMultiItemDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :multi_item_discounts do |t|
      t.string :upc
      t.integer :required_for_discount
      t.decimal :discount_at_required
      t.string :description

      t.timestamps
    end
  end
end
