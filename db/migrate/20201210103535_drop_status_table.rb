class DropStatusTable < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :orders, :statuses
    drop_table :statuses
  end
end
