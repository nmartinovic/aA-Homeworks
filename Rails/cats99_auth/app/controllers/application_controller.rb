class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        return nil if self.session[:session_token].nil?
        @user ||= User.find_by(session_token: self.session[:session_token])
    end
end
