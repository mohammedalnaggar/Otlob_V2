class UpdateNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :msg, :string
  end
end
