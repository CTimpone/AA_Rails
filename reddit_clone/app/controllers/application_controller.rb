class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def sign_in!(user)
    user.reset_session_token
    session[:token] = user.session_token
  end

  def sign_out!(user)
    user.reset_session_token
    session[:token] = nil
    redirect_to new_session_url
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def signed_in?
    !!current_user
  end

  def ensure_signed_in
    unless signed_in?
      flash[:errors] = ["Must be signed in to complete action."]
      redirect_to new_session_url
    end
  end
end
