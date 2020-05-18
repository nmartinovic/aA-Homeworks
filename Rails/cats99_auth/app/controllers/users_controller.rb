
class UsersController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save!
            @user = User.find_by_credentials(params[:user][:user_name],params[:user][:password])
        #fail
            if @user.nil? 
                render json: "this did not work"
            end

            @user.reset_session_token!
            self.session[:session_token] = @user.session_token
            redirect_to cats_url
        else
            render :new
        end
    end


    private
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end