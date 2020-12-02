class Admins::RoomsController < Admins::BaseController
  def index
    @rooms = Room.all
                 .includes(:category)
                 .page(params[:page])
                 .per Settings.rooms.num_record
  end
end
