class Account < ApplicationRecord
    belongs_to :user
    validates :account_name, :account_no, :balance, presence: true
    validates :account_no, uniqueness: true

end
