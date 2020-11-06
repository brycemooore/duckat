class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    def home
    end 

    def current_user
        if session[:username].present?
            return User.find_by(username: session[:username])
        end
    end 

    def logged_in?
        !!current_user
    end 

end
