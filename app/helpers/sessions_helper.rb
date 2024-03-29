module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) # if @current_user is nil, then find user by id in session
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in? # returns true if user is logged in
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end