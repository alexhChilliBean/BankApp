class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :reference
      t.integer :amount
      t.references :accounts
      t.references :users
      t.timestamps

    end
  end
end
