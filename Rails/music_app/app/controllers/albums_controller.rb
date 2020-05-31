class AlbumsController < ApplicationController

    def new
        @band = Band.find_by(id: params[:band_id])
        render json: "Create a new album for #{@band.name}"

    end
end