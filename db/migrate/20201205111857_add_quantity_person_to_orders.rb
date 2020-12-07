class AddQuantityPersonToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :quantity_person, :integer
  end
end
