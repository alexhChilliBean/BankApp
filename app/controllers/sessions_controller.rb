class SessionsController < ApplicationController
    def create
        @user = User.find_by(username: params[:username])

        if !!@user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:success] = "Welcome back!"
            redirect_to user_path(@user)
        else
            message = "Incorrect username or password"
            redirect_to login_path, notice: message
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You have been logged out."
        redirect_to login_path
    end
    
end
