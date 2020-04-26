class UsersController < ApplicationController

    def index
        if params[:query].nil? == false
            user = User.where("username like (?)","%#{params[:query]}%")
            render json: user
        else
            render json: User.all
        end
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        render json: User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        user.update!(user_params)
        render json: user
    end

    def destroy
        user = User.destroy(params[:id])
        render json: user
    end

    private

    def user_params
        params.require(:user).permit(:username,:query)
    end
end