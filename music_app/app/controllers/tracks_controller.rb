class TracksController < ApplicationController
  before_action :require_logged_in, except: :show

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = current_track
    render :edit
  end

  def update
    @track = current_track
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    track = current_track
    redirect_to album_url(track.album_id)
    track.destroy
  end

  def track_params
    params.require('track').permit(:bonus, :name, :album_id, :lyrics)
  end

  def current_track
    Track.find(params[:id])
  end
end
