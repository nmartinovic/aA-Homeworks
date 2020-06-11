class TracksController < ApplicationController

    def new
        #page to create a new track
        #render :new
        @track = Track.new
        render :new
    end

    def create
        #post request for the new track
        @track = Track.new(track_params)
        if @track.save
            redirect_to album_url(@track.album_id)
        else
            render json: "This did not work"
        end
    end

    def edit
        #page to edit a track
        @track = Track.find_by(id: params[:id])
        @album = Album.find_by(id: @track.album_id)
        render :edit
    end

    def show
        #shows a specific track
        @track = Track.find_by(id: params[:id])
        render :show
    end

    def update
        #request to update a track
        @track = Track.find_by(id: params[:id])
        @album = Album.find_by(id: @track.album_id)
        if @track.update_attributes(track_params)
            render json: "Update Successful"
        else
            flash.now[:errors] = @band.errors.full_messages
            render json: "This was not successful"
        end
    end

    def destroy
        #destroy the track
        @track = Track.find_by(id: params[:id])
        @track.destroy
        redirect_to album_url(@track.album_id)

    end

    def track_params
        params.require(:track).permit(:album_id, :ord, :lyrics, :name, :bonus?)
    end
end