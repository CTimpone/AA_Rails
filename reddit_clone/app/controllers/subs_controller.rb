class SubsController < ApplicationController
  before_action :ensure_signed_in, only: [:new, :create]
  before_action :is_moderator, only: [:edit, :update]
  before_action :verify_sub_path, only: :show


  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def is_moderator
    current_sub = Sub.find(params[:id])
    unless current_user == current_sub.user
      flash[:errors] = ["Must be sub owner to complete that action."]
      redirect_to sub_url(current_sub)
    end
  end

  def verify_sub_path
    if Sub.find_by(id: params[:id]).nil?
      flash[:errors] = ["Invalid sub page."]
      redirect_to subs_url
    end
  end

end
