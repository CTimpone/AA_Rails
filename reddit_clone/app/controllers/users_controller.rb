class UsersController < ApplicationController
  before_action :verify_user_path, only: :show
  def new
    @user = User.new
    render :new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      sign_in!(@user)
      redirect_to subs_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def verify_user_path
    if User.find_by(id: params[:id]).nil?
      flash[:errors] = ["Invalid user page."]
      redirect_to subs_url
    end
  end
end
