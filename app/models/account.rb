class Account < ApplicationRecord
    acts_as_paranoid
    belongs_to :user
    has_many :transactions
    validates :account_name, :account_no, :balance, presence: true
    validates :account_no, uniqueness: true
    validates :account_name, uniqueness: { scope: :user_id , conditions: -> { where(deleted_at: nil) } }
    validates :balance, numericality: {greater_than_or_equal_to: 0}

end
