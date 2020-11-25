class CreateRoomSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :room_supplies do |t|
      t.references :room, null: false, foreign_key: true
      t.references :supply, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
