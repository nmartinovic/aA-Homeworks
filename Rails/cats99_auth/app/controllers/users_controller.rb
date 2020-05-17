
class UsersController < ApplicationController

    def new
        render json: "this is a new user"
    end

    def create
        @user = User.new(user_params)

        if @user.save!
            render cats_url
        else
            render new_cat_url
        end
    end


    private
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end