class User < ApplicationRecord
    has_many :accounts
    has_secure_password
    validates :first_name, :last_name, :username, :password, presence: true
    validates :username, uniqueness: true
end
