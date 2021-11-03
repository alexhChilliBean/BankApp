class ChangeBalanceToBeFloatInAccounts < ActiveRecord::Migration[6.1]
  def change
    change_column :accounts, :balance, :float
  end
end
