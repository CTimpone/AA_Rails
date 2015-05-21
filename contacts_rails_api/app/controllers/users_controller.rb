class UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    user.save
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: user
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    render json: user
  end

  protected

    def user_params
      params.require(:user).permit(:username)
    end

end
