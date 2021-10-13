class AccountsController < ApplicationController
    before_action :find_user
    
    def new
        @account = Account.new
    end

    private

    def find_user
        @user = User.find(params[:user_id])
    end

end