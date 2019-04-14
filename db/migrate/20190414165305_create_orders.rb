class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :restaurant
      t.integer :order_for
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
