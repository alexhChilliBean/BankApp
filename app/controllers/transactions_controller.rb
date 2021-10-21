class TransactionsController < UsersController
    before_action :find_user

    def new
        @transaction = Transaction.new
        @account = @user.accounts.find(params[:transaction][:reference])
    end

    def create
        userID = params[:user_id]
        @account = @user.accounts.find(params[:account_name])
        @transaction = Transaction.new(transaction_params)
        @transaction.user_id = userID
        @transaction.account_no = rand(1..999999)
        if @transaction.save
            flash[:success] = "New Account Opened"
            return redirect_to user_url(@user.id)
        else
            flash[:error] = @transaction.errors.full_messages
            render 'new'
        end
    end

    private
    def find_user
        @user = User.find(params[:user_id])
    end
end
