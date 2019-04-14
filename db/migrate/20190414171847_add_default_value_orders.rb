class AddDefaultValueOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :order_for, :integer, default: 0
  end
end

