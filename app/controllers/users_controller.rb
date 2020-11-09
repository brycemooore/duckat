class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end 

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id 
            redirect_to login_path
        else 
            render :new
        end 
    end 

    def show
    end 

    def edit
    end 

    def update
        if @user.update(user_params)
            redirect_to user_path(@user.id)
        else
            render :edit
        end 
    end 

    def destroy
        @user.delete
        redirect_to home_path
    end 

    private 
    def set_user
        @user = User.find(current_user.id)
    end

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end 
end
