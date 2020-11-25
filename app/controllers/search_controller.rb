class SearchController < ApplicationController
  def index
    @rooms = Room.search_by_name(params[:name])
                 .search_by_price(params[:price])
                 .page(params[:page]).per Settings.rooms.num_record
  end
end
