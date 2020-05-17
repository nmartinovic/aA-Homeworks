class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        #verify the username and password
        #Reset the user's session token
        #update the session hash with the new session token
        #redirect to cats_index page

        @user = User.find_by_credentials(params[:user][:user_name],params[:user][:password])

        if @user.nil? 
            render json: "this did not work"
        end

        @user.reset_session_token!
        session[:session_token] = @user.session_token
        redirect_to cats_url
    end

    def destroy
        if !current_user.nil?
            current_user.reset_session_token!
        end
        session[:session_token] = nil
    end

    private 
    def session_params
        params.require(:user).permit(:user_name, :password)
    end
end