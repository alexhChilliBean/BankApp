class TransactionsController < UsersController
    before_action :find_user

    def new
        @transaction = Transaction.new
        @account = @user.accounts.find(params[:transaction][:sender_id])
    end

    def create
        @transaction = Transaction.new(transaction_params)
        @account = @user.accounts.find(@transaction.sender_id)
        @receiver = find_receiver
        @receiver_act = find_receiver_act
        if account_has_sufficient_funds && @transaction.save
        @account.update(:balance => (@account.balance - @transaction.amount))
        @receiver_act.update(:balance => (@receiver_act.balance + @transaction.amount))
        flash[:success] = "Transaction Completed"
        redirect_to user_url(@user)
        else
        flash[:error] = @transaction.errors.full_messages
        render 'new'
        end
    end

    private
    def find_receiver
        receiver = User.find_by(username: @transaction.receiver_name)
        if receiver.present?
            return receiver
        else
            flash[:notice] = "User does not exist"
            render 'new'
        end
    end

    def find_receiver_act
        receiver_act = @receiver.accounts.find_by(account_name: @transaction.receiver_act)
        if receiver_act.present?
            return receiver_act
        else
            flash[:notice] = "Account does not exist"
            render 'new'
        end
    end

    def account_has_sufficient_funds
        if @account.balance >= @transaction.amount
            return true
        else
            flash[:notice] = "Insufficient funds"
            render 'new'
        end
    end
    
    def find_user
        @user = User.find(params[:user_id])
    end

  
    def transaction_params
        params.require(:transaction).permit(:transaction_id, :accounts_id, :users_id, :sender_id, :sender_name, :receiver_name, :receiver_act, :amount, :reference)
    end
end
