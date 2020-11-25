class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:rooms)
    return if @categories.present?

    flash[:danger] = t "something_wrong"
    redirect_to root_path
  end
end
