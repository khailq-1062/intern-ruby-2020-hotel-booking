class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :date_start
      t.datetime :date_end
      t.float :price

      t.timestamps
    end
  end
end
