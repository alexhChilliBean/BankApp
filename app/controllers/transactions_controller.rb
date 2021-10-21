class TransactionsController < UsersController
    before_action :find_user

    def new
        @transaction = Transaction.new
        @account = @user.accounts.find(params[:transaction][:sender_id])
    end

    def create
        @user = User.find(params[:user_id])
        @transaction = Transaction.new(transaction_params)
        @account = @user.accounts.find(params[:transaction][:sender_id])
        if User.find_by(username: :receiver_name).accounts.find_by(account_name: :receiver_act)
            @receiver = User.find_by(username: :receiver_name)
            @receiver_act = @receiver.accounts.find_by(account_name: :receiver_act)
            if @account.balance >= @transaction.amount
                if @transaction.save
                    @account.balance = @account.balance - @transaction.amount
                    @receiver_act.balance = @receiver_act.balance + @transaction.amount
                    flash[:success] = "New Account Opened"
                    return redirect_to user_url(@user.id)
                else
                    flash[:error] = @transaction.errors.full_messages
                    render 'new'
                end
                
            else
                flash[:error] = "Insufficient Funds"
            end
            
        else
            flash[:error] = "Incorrect User or Account"
        end
        
    end

    private
    def find_user
        @user = User.find(params[:user_id])
    end

    private
    def transaction_params
        params.require(:transaction).permit(:sender_id, :receiver_name, :receiver_act, :amount, :reference)
    end
end
