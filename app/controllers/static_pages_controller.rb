class StaticPagesController < ApplicationController
  def home
    @rooms = Room.includes(:category)
                 .top_hired.limit Settings.model.limit.top_hired_home_page
  end
end
