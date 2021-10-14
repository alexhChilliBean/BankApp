class SessionsController < ApplicationController
    def create
        @user = User.find_by(username: params[:username])

        if !!@user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] = "Incorrect Username or Password"
            redirect_to login_path
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You have been logged out."
        redirect_to login_path
    end
    
end
