class Admins::OrdersController < Admins::BaseController
  def index
    @orders = Order.all
                   .includes(:room, :user)
                   .page(params[:page])
                   .per Settings.rooms.num_record
  end
end
