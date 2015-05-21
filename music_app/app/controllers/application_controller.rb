class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?,
                :log_in_user!, :has_note_on_track?,
                :current_note, :ugly_lyrics

  def current_user
    User.find_by(session_token: session[:token])
  end

  def logged_in?
    !!current_user
  end

  def activated?
    current_user.activated
  end

  def log_in_user!(user)
    session[:token] = User.generate_session_token
    user.update!(session_token: session[:token])
  end

  def log_out_user!(user)
    session[:token] = nil
    user.update!(session_token: User.generate_session_token)
  end

  def user_params
    params.require('user').permit(:email, :password)
  end

  def require_logged_in
    unless logged_in?
      session[:prev_url] = request.referer
      redirect_to new_session_url
    end
  end

  def has_note_on_track?
    !!current_note
  end

  def current_note
    return nil if current_user.nil?
    Note.find_by(user_id: current_user.id, track_id: params[:id])
  end

  def ugly_lyrics(lyrics)
    html = "&#9835 "
    html += lyrics.gsub("\r\n","\r\n&#9835 ")
    html.html_safe
  end
end
