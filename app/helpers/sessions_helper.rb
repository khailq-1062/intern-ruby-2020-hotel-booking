module SessionsHelper
  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def current_user? user
    user && user == current_user
  end

  def login user
    session[:user_id] = user.id
  end
end
