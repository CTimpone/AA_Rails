class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params)
    if user.nil?
      @user = User.new(user_params)
      flash[:errors] = ["Invalid username/password combination"]
      render :new
    elsif !user.activated
      flash[:errors] = ["You must verify your email"]
      redirect_to bands_url
    else
      log_in_user!(user)
      if session[:prev_url]
        redirect_to session[:prev_url]
        session[:prev_url] = nil
      else
        redirect_to user_url(user)
      end
    end
  end

  def destroy
    log_out_user!(current_user)
    redirect_to new_session_url
  end

end
