FactoryBot.define do
    factory :account do
        account_name { "Savings ISA" }
        account_no { 12345 }
        balance { 3000 }
        user_id { user.id }
    end
end