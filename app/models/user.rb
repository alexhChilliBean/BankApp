class User < ApplicationRecord
    has_many :accounts
    has_secure_password
    validates :first_name, :last_name, :username, :password, :email presence: true
    validates :username, :email uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
