class ArtworksController < ApplicationController

    # def index
    #     render json: Artwork.all
    # end

    def index
        #
        #artist  = User.find(params[:user_id])
        render json: Artwork.artworks_for_user_id(params[:user_id])
    end

    def create
        artwork = Artwork.new(user_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        render json: Artwork.find(params[:id])
    end

    def update
        artwork = Artwork.find(params[:id])
        artwork.update!(user_params)
        render json: artwork
    end

    def destroy
        artwork = Artwork.destroy(params[:id])
        render json: artwork
    end

    private

    def user_params
        params.require(:artwork).permit(:title, :image_url,:artist_id)
    end

end