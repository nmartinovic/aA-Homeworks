class BandsController < ApplicationController

    def create
        @band = Band.new(band_params)
        if @band.save!
            render json: "this worked!"
        else
            render json: "this returned an error"
        end
    end

    def index
        @band = Band.find_by(id: params[:id])
        render json: @band
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end