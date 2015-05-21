class NotesController < ApplicationController
  before_action :require_logged_in

  def create
    Note.create(user_id: current_user.id, track_id: params[:track_id], note: note_params[:note])
    redirect_to track_url(params[:track_id])
  end

  def edit
    Note.find_by(user_id: current_user.id, track_id: params[:track_id])
  end

  def update
    note = current_note_in_track
    note.update(note_params)
    redirect_to track_url(params[:track_id])
  end

  def destroy
    current_note_in_track.destroy
    redirect_to track_url(params[:track_id])
  end

  def note_params
    params.require('note').permit(:note)
  end

  def current_note_in_track
    return nil if current_user.nil?
    Note.find_by(user_id: current_user.id, track_id: params[:track_id])
  end

end
