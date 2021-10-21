class TransactionsController < UsersController
    before_action :find_user

    def new
        @transaction = Transaction.new
        @account = @user.accounts.find(params[:transaction][:sender_id])
    end

    def create
        @transaction = Transaction.new(transaction_params)
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

    private
    def transaction_params
        params.require(:transaction).permit(:sender_id, :receiver_name, :receiver_act, :amount, :reference)
    end
end
