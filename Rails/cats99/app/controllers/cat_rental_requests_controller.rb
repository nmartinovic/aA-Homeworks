class CatRentalRequestsController < ApplicationController

    def index
        render :index
    end

    def create
        @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

        if @cat_rental_request.save
            redirect_to cats_url
        else
            render json: 'ERROR'
        end
    end

    def approve
        @cat_rental_request = CatRentalRequest.find_by(id: params[id])
        @cat_rental_request.approve!
        render :index
    end

    def deny
        @cat_rental_request = CatRentalRequest.find_by(id: params[id])

        @cat_rental_request.deny!
        render :index
    end


    private
    def cat_rental_request_params
        params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date)
    end
end