class SessionsController < ApplicationController

    def create
        @user = User.find_by_credentials(params[:user][:email],params[:user][:password])
        
        if @user.nil?
            render json: "wrong credentials"
        else
            login!(@user)
            redirect_to user_url(@user)
        end
    end

    def new
        render  :new
    end

    def destroy
        logout!
        redirect_to new_user_url
    end




    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end