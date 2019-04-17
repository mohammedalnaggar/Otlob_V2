class CreateOrderUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :order_users do |t|
      t.integer :status, default: 0
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
