class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(username: params[:username])
        if @user == nil
            redirect_to new_user_path(failed_to_find_user: true)
        elsif @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to home_path
        else 
            redirect_to login_form_path(failed_to_find_user: true)
        end 
    end 

    def destroy
        if logged_in?
            session.delete :user_id
        end
        redirect_to home_path
    end 

end
