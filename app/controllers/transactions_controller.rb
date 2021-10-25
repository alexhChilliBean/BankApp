class TransactionsController < UsersController
    before_action :find_user

    def new
        @transaction = Transaction.new
        @account = @user.accounts.find(params[:transaction][:sender_id])
    end


    def create
        @transaction = Transaction.new(transaction_params)
        @account = @user.accounts.find(params[:transaction][:sender_id])
        if User.find_by(username: params[:transaction][:receiver_name])
            @receiver = User.find_by(username: params[:transaction][:receiver_name])
            if @receiver.accounts.find_by(account_name: params[:transaction][:receiver_act])
                @receiver_act = @receiver.accounts.find_by(account_name: @transaction.receiver_act)
                if @account.balance >= @transaction.amount
                    @account.update(:balance => (@account.balance - @transaction.amount))
                    @receiver_act.update(:balance => (@receiver_act.balance + @transaction.amount))
                    @transaction.save
                    flash[:success] = "Transaction Completed"
                    redirect_to user_url(@user)
                else
                    flash[:success] = "Insufficient funds"
                    render 'new'
                end
            else
                flash[:success] = "Account must exist"
                render 'new'
            end
        else
            flash[:success] = "User must exist"
            render 'new'
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
