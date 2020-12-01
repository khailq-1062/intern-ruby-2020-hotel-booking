class UsersController < ApplicationController
  before_action :find_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "register_successful"
      login @user
      redirect_to root_path
    else
      flash[:danger] = t "register_failed"
      render :new
    end
  end

  def show
    return if current_user? @user

    flash[:success] = t "something_wrong"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit User::USER_PERMIT
  end

  def find_user
    @user = User.find params[:id]
    return if @user

    flash[:danger] = t "something_wrong"
    redirect_to root_path
  end
end
