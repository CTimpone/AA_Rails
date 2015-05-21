class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new
    user = User.find_by_credentials(user_params)
    if !user
      flash[:errors] = ["Invalid username/password combination"]
      render :new
    else
      sign_in!(user)
      redirect_to subs_url
    end
  end

  def destroy
    sign_out!(current_user)
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
