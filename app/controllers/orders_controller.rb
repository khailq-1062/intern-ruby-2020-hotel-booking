class OrdersController < ApplicationController
  before_action :check_login
  before_action :find_room, only: %i(new create)
  before_action :valid_date_for_booking,
                :get_booked_room_for_booking,
                only: :new

  before_action :check_max_person,
                only: :create

  layout false, only: :new

  def index
    @orders = current_user.orders.includes(:room, :status)
                          .order_id_desc
                          .order_status_asc
                          .page(params[:page])
                          .per Settings.per.order
  end

  def new
    return request.referer unless @booked_room.empty?

    @order = current_user.orders.new
    @quantity_person = params[:quantity_person]
    @total_pay = (@date_end.to_date - @date_start.to_date + 1) * @room.price
  end

  def create
    order = current_user.orders.build order_params
    if order.save
      flash[:success] = t "flash_create_new_order_success"
    else
      flash[:danger] = t "something_wrong"
    end
    redirect_to root_path
  end

  private

  def order_params
    params[:order].merge! room_id: params[:room_id],
                          price: @room.price * (get_total_date + 1),
                          status_id: 1,
                          booking_attributes: booking_params
    params.require(:order).permit Order::ORDER_PARAMS
  end

  def check_login
    return if logged_in?

    flash[:danger] = t "login_to_continue"
    redirect_to login_path
  end

  def find_room
    @room = Room.find_by id: params[:room_id]
    return if @room.present?

    flash[:danger] = t "something_wrong"
    redirect_to root_path
  end

  def booking_params
    {room_id: params[:order][:room_id],
     date_start: params[:order][:date_start],
     date_end: params[:order][:date_end],
     quantity_person: params[:order][:quantity_person]}
  end

  def check_max_person
    return if params[:order][:quantity_person].to_i <= @room.max_person

    flash[:danger] = t ".warning_for_quantity_person"
    redirect_to request.referer
  end

  def get_total_date
    return 0 if params[:order][:date_start].blank? ||
                params[:order][:date_end].blank?

    (params[:order][:date_end].to_date - params[:order][:date_start].to_date)
  end
end
