class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :room
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps
    end
  end
end
