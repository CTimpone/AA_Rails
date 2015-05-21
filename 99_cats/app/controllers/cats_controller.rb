class CatsController < ApplicationController
  before_action :is_owner, :existing_cat
  skip_before_action :is_owner, except: [:edit, :update]
  skip_before_action :existing_cat, except: [:show]


  def index
    @cats = Cat.all
    render :index
  end

  def show
    cat = Cat.find(params[:id])
    @attributes = cat.attributes
    @description = @attributes["description"]
    @owner = @attributes["user_id"]
    @attributes.delete('user_id')
    @attributes.delete('created_at')
    @attributes.delete('updated_at')
    @attributes.delete('description')
    @cat_rental_requests = cat.rental_requests
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :description, :birth_date)
  end

  def is_owner
    @cat = Cat.find(params[:id])
    if @cat.owner != current_user
      redirect_to :back
    end
  end

  def existing_cat
    if Cat.where(id: params[:id]).empty?
      redirect_to cats_url
    end
  end
end
