class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user, :ensure_signed_in

  def log_in_user(user)
    session[:token] = user.reset_session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def signed_in?
    !!current_user
  end

  def log_out
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def ensure_signed_in
    redirect_to new_session_url unless signed_in?
  end

end
