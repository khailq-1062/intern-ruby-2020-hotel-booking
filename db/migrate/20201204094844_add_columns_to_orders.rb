class AddColumnsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :room, null: false, foreign_key: true
    add_column :orders, :date_start, :date
    add_column :orders, :date_end, :date
    add_column :orders, :price, :float
  end
end
