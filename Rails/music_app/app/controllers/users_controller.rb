class UsersController < ApplicationController
      before_action :require_current_user!, except: [:create, :new]

    def create
        @user = User.new(user_params)

        if @user.save!
            login!(@user)
            redirect_to user_url(@user)
        else
            render json: "There was an error"
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    def index
        users = User.all
        render json: users
    end

    def new
        render :new
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end

end
