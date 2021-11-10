FactoryBot.define do
    factory :transaction do
        amount { 300 }
        reference { "test" }
        sender_id { 1 }
        receiver_name { "receiver" }
        receiver_act { "Savings ISA" }
        sender_name { "sender" }

    end
end