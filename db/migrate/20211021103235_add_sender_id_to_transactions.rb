class AddSenderIdToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :sender_id, :string
    add_column :transactions, :receiver_name, :string
    add_column :transactions, :receiver_act, :string
    remove_column :transactions, :to_user, :string
  end
end
