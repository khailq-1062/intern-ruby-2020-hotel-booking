class BookingsController < ApplicationController
  before_action :valid_date_for_booking,
                :get_booked_room_for_booking

  def check_room
    return @status = Booking::STATUSES[:failed] if @date_start > @date_end

    @quantity_person = params[:quantity_person].to_i
    @status =
      if @booked_room.empty?
        Booking::STATUSES[:open]
      else
        Booking::STATUSES[:close]
      end
  end
end
