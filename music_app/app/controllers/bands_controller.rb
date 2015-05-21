class BandsController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = current_band
    render :show
  end

  def edit
    @band = current_band
    render :edit
  end

  def update
    @band = current_band
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def destroy
    band = current_band
    redirect_to bands_url
    current_band.destroy
  end

  def band_params
    params.require('band').permit(:name)
  end

  def current_band
    Band.find(params[:id])
  end
end
