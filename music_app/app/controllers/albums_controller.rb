class AlbumsController < ApplicationController
  before_action :require_logged_in, except: :show

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = current_album
    render :edit
  end

  def update
    @album = current_album
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    album = current_album
    redirect_to band_url(album.band_id)
    album.destroy
  end

  def album_params
    params.require('album').permit(:live, :name, :band_id)
  end

  def current_album
    Album.find(params[:id])
  end
end
