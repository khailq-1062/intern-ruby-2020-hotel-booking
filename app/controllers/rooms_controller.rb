class RoomsController < ApplicationController
  before_action :find_cate, only: :index
  before_action :find_room, only: :show

  def index
    @rooms = @cate.rooms.page(params[:page]).per Settings.rooms.num_record
  end

  def show
    @relate_rooms = Room.relate_room(@room.category_id)
                        .random_room.limit Settings.rooms.relate_recored
  end

  private

  def find_cate
    @cate = Category.find_by slug: params[:slug]
    return if @cate

    flash[:danger] = t "rooms.cate_not_found"
    redirect_to root_path
  end

  def find_room
    @room = Room.find_by slug: params[:slug]
    return if @room

    flash[:danger] = t "rooms.room_not_found"
    redirect_to root_path
  end
end
