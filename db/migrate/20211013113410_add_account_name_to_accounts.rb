class AddAccountNameToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :account_name, :string
  end
end
