class SessionsController < ApplicationController
  before_action :logged_in_redirect
  skip_before_action :logged_in_redirect, only: [:destroy]

  def new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:username, :password)
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user.nil?
      flash.now[:errors] = ["Invalid username/password combination"]
      render :new
    else
      login_user!(@user)
    end
  end

  def destroy
    sign_out!
    redirect_to cats_url
  end
end
