class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.string :item
      t.integer :amount
      t.float :price
      t.string :comment
      t.references :order_user, foreign_key: true

      t.timestamps
    end
  end
end
