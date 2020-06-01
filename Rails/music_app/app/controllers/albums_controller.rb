class AlbumsController < ApplicationController

    def new
        @band = Band.find_by(id: params[:band_id])
        render :new

    end

    def create
        @album = Album.new(album_params)
        if @album.save
            render json: "#{@album.name} is saved!"
        else
            render json: "ERROR!!!"
        end
    end

    def edit
        @album = Album.find_by(id: params[:id])
        render json: "Replace this with an edit template for #{@album.name}"
    end

    def show
        @album = Album.find_by(id: params[:id])
        render json: "This is the show page for #{@album.name}"
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