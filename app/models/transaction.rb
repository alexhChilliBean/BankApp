class Transaction < ApplicationRecord
    belongs_to :account, optional: true
    validates :amount, :reference, :sender_id, :receiver_name, :receiver_act, :sender_name, presence: true
    validates :receiver_name, exclusion: { in: :sender_name }
    validates :amount, numericality: {greater_than: 0}
end
