class AddSenderNameToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :sender_name, :string
  end
end
