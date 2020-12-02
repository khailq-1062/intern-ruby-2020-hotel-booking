class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def valid_date_for_booking
    @date_start = params[:date_start].presence || Time.zone.today.to_s
    @date_end = params[:date_end].presence || @date_start
  end

  def get_booked_room_for_booking
    @booked_room = Booking.by_room_id(params[:room_id])
                          .check_status_by_date @date_start, @date_end
  end
end
