class AlbumsController < ApplicationController

    def new
        @band = Band.find_by(id: params[:band_id])
        render :new

    end

    def create
        @album = Album.new(album_params)
        if @album.save
            redirect_to band_url(@album.band_id)
        else
            render json: "ERROR!!!"
        end
    end

    def edit
        @album = Album.find_by(id: params[:id])
        render :edit
    end

    def show
        @album = Album.find_by(id: params[:id])
        render :show
    end

    def update
        @album = Album.find_by(id: params[:id])
        if @album.update_attributes(album_params)
            render json: @album.attributes
        else
            render json: "This caused an error"
        end
    end

    def destroy
        @album = Album.find_by(id: params[:id])
        @album.destroy
    end

    private

    def album_params
        params.require(:album).permit(:name, :band_id, :year, :studio?)
    end
end