class UsersController < ApplicationController
  before_action :logged_in_redirect

  def new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:username, :password)
    user = User.new(user_params)

    if user.save
      login_user!(user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

end
