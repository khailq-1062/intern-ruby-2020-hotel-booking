class RoomsController < ApplicationController
  before_action :find_cate, only: :index

  def index
    @rooms = @cate.rooms.page(params[:page]).per Settings.rooms.num_record
  end

  private

  def find_cate
    @cate = Category.find_by slug: params[:slug]
    return if @cate

    flash[:danger] = t ".cate_not_found"
    redirect_to root_path
  end
end
