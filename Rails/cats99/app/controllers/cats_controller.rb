class CatsController < ApplicationController

    def index
        @cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find_by(id: params[:id])
        render :show
    end

    def new
        render :new
    end

    def edit
    end

    def create
        render json: "Creating cat"
    end


    private
    def cat_params
        params.require(:cat).permit(:birth_date, :color, :sex, :name, :description)
    end
end