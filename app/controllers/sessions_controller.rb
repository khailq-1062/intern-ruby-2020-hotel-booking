class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:danger] = t "sessions.login_false"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
