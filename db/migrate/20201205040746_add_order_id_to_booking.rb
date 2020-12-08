class AddOrderIdToBooking < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :order, null: false, foreign_key: true
  end
end
