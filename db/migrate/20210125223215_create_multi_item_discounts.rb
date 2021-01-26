class CreateMultiItemDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :multi_item_discounts do |t|
      t.string :upc
      t.string :string
      t.string :required_for_discount
      t.string :integer
      t.string :discount_at_required
      t.string :decimal
      t.string :description
      t.string :text

      t.timestamps
    end
  end
end
