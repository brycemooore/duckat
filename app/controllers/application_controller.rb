class ApplicationController < ActionController::Base

    helper_method :current_user

    def home
    end 

    def current_user
        if session[:username].present?
            return User.find_by(username: session[:username])
        end
    end 

end
