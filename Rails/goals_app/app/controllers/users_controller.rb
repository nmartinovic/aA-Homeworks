class UsersController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.new(email:params["user"]["email"],password:params["user"]["password"])
        if @user.valid?
            @user.save
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        render :show
    end
end
