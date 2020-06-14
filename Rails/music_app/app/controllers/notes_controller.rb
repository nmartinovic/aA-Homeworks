class NotesController < ApplicationController


def create
    @user = User.find_by(session_token: session[:session_token])
    @note = Note.new(user_id: @user.id, track_id: params[:note][:track_id],text:params[:note][:text])
    @note.save
    redirect_to track_url(params[:note][:track_id])
end

def destroy
    
    @note = Note.find_by(id: params[:id])
    @note.destroy
    redirect_to track_url(@note.track_id)
end

private


end