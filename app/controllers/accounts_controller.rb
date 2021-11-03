class AccountsController < ApplicationController
    before_action :find_user
    
    def new
        @account = Account.new
    end

    def create
        userID = params[:user_id]
        @account = Account.new(account_params)
        @account.user_id = userID
        @account.account_no = rand(1..999999)
        if @account.save
            flash[:success] = "New Account Opened"
            return redirect_to user_url(@user.id)
        else
            flash[:error] = @account.errors.full_messages
            render 'new'
        end
    end

    
    def destroy
        
        @account = Account.find(params[:id])
        if @account.destroy
            flash[:notice] ="Account Deleted"
            redirect_to root_path
        else
            flash[:error]="Failed to delete account"
        end
    end

    private
    def account_params
        params.require(:account).permit(:balance, :account_name, :user_id)
    end

    private
    def find_user
        @user = User.find(params[:user_id])
    end

end
