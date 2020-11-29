class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :slug
      t.references :category, null: false, foreign_key: true
      t.float :price
      t.string :ward_id
      t.integer :max_person
      t.text :description
      t.integer :hired, default: 0
      t.text :map
      t.timestamps
    end
  end
end
