class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :is_owner?

  def current_user
    token = session[:token]
    ses = Session.find_by(token: token)
    return nil if ses.nil?
    ses.user
  end

  def signed_in?
    !!current_user
  end

  def sign_out!
    token = session[:token]
    ses = Session.find_by(token: token)
    ses.delete
    session[:token] = nil
  end

  def login_user!(user)
    token = user.new_session_token!
    session[:token] = token
    redirect_to cats_url
  end

  def logged_in_redirect
    if signed_in?
      redirect_to cats_url
    end
  end

  def is_owner?
    @cat = Cat.find(params[:id])
    @cat.owner == current_user
  end

end
