class SessionsController < ApplicationController
    def new
    end

    def create
        if params[:username].present?
            @user = User.find_by(username: params[:username])
            return head(:forbidden) unless @user.authenticate(params[:password])
            session[:user_id] = @user.id
            session[:username] = params[:username]
            redirect_to home_path
        else 
            redirect_to login_form_path
        end 
    end 

    def destroy
        if logged_in?
            session.delete :user_id
        end
        redirect_to home_path
    end 

end
