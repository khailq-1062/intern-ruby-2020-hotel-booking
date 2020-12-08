class BookingsController < ApplicationController
  before_action :valid_date_for_booking,
                :get_booked_room_for_booking

  layout false

  def check_room
    return @status = Booking::STATUSES[:close] if @date_start > @date_end

    @status =
      if @booked_room.empty?
        Booking::STATUSES[:open]
      else
        Booking::STATUSES[:close]
      end
    render json: @status
  end
end
