class AddToUserToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :to_user, :string
  end
end
