class SessionsController < ApplicationController
    def new
    end

    def create
        if params[:username].present?
            session[:username] = params[:username]
            redirect_to home_path
        else 
            redirect_to login_form_path
        end 
    end 

    def destroy
        if session[:username].present?
            session.delete :username
        end
        redirect_to home_path
    end 

end
