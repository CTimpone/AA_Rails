class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      log_in_user(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid username/password combination."]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
