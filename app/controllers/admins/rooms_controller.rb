class Admins::RoomsController < Admins::BaseController
  def index
    @rooms = Room.all
                 .includes(:category)
                 .page(params[:page])
                 .per Settings.rooms.num_record
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params
    if @room.save
      flash[:success] = t "admins.rooms.add_success"
      redirect_to new_admins_room_path
    else
      flash.now[:danger] = t "admins.rooms.add_false"
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit Room::ROOM_PERMIT
  end
end
