class CatRentalRequestsController < ApplicationController
  before_action :is_owner, :is_signed_in
  skip_before_action :is_owner, except: [:approve, :deny]

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_requests_params)
    @cat_rental_request.user_id = current_user.id
    if @cat_rental_request.save
      redirect_to cat_url(cat_rental_requests_params[:cat_id])
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def cat_rental_requests_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end

  def approve
    id = params[:id].to_i
    request = CatRentalRequest.find(id)
    request.approve!
    redirect_to :back
  end

  def deny
    id = params[:id].to_i
    request = CatRentalRequest.find(id)
    request.deny!
    redirect_to :back
  end

  def is_owner
    request = CatRentalRequest.find(params[:id])
    @cat = request.requested_cat
    if @cat.owner != current_user
      redirect_to :back
    end
  end

  def is_signed_in
    unless signed_in?
      redirect_to :new_sessions
    end
  end
end
