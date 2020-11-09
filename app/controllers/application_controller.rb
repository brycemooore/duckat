class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    def home
    end 

    def current_user
        if session[:user_id].present?
            return User.find(session[:user_id])
        end
    end 

    def logged_in?
        !!current_user
    end 

end
