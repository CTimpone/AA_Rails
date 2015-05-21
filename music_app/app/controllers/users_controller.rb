class UsersController < ApplicationController

  before_action :redirect_sign_in, only: :show

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:errors] = ["Before you can fully use the system, please verify your account via email."]
      redirect_to bands_url
    else
      flash[:errors] = user.errors.full_messages
      @user = user
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def activate_form
    render :activate_form
  end

  def activate
    user = User.find_by(activation_token: params[:activation_token])
    if user.nil? || user != User.find(params[:user_id])
      flash[:errors] = ["Activation link does not match our records."]
      redirect_to bands_url
    else
      user.activated = true
      flash[:errors] = ["Email successfully verified"]
      log_in_user!(user)
      redirect_to bands_url(user)
    end
  end

  def redirect_sign_in
    unless logged_in?
      redirect_to new_session_url
    end
  end
end
