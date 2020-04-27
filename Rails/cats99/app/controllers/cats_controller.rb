#finish this update/create

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
        @cat = Cat.find_by(id: params[:id])
        render :edit
    end

    def update

    end

    def create
        @cat = Cat.new(cat_params)

        if @cat.save
            redirect_to cat_url(@cat)
        else
            render :new
        end
    end


    private
    def cat_params
        params.require(:cats).permit(:birth_date, :color, :sex, :name, :description)
    end
end