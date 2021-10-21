class UsersController < ApplicationController
    
    before_action :check_login, except: [:new, :create]
    before_action :check_user, except: [:new, :create]

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
        @accounts = @user.accounts
        @transaction = Transaction.new
    end

    def new_transaction
        @user=User.find(params[:id])
        redirect_to new_user_transaction(@user.id)
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
