class UsersController < ApplicationController
    
    before_action :check_login
    before_action :check_user

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Account Created"
            redirect_to root_path
        else
            flash[:error] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :first_name, :last_name)
    end

    def check_login
        unless helpers.logged_in?
            redirect_to login_path
        end           
    end

    def check_user
        unless helpers.current_user.id == params[:id].to_i
            redirect_to unauthorised_url
        end
    end

end
