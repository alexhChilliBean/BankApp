class Transaction < ApplicationRecord
    belongs_to :user, through :account
end
