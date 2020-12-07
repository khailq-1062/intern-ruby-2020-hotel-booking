class Booking < ApplicationRecord
  BOOKING_PARAMS = %i(room_id date_start date_end quantity_person).freeze
  STATUSES = {open: "open", close: "close", failed: "failed"}.freeze

  scope :by_room_id, ->(room_id){where room_id: room_id}
  scope :check_status_by_date, (lambda do |date_start, date_end|
    where "((date_start BETWEEN '#{date_start}' AND '#{date_end}')
            OR (date_end BETWEEN '#{date_start}' AND '#{date_end}')
            OR (date_start < '#{date_start}' AND date_end > '#{date_end}'))"
  end)
end
