class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        return nil if self.session[:session_token].nil?
        @user ||= User.find_by(session_token: self.session[:session_token])
    end

    def log_in(user)
        user.reset_session_token!
        self.session[:session_token] = user.session_token
    end

    def logged_in?
        #current_user
        if !current_user.nil?
            redirect_to cats_url
        end
    end
end
