require 'rails_helper'
RSpec.describe TransactionsController, type: :controller do
    describe "POST create" do
        it "assigns transaction" do
            user = FactoryBot.create(:user)
            account = FactoryBot.create(:account, user_id: user.id)
            post :create, params: {transaction: { user_id: user.id, amount: 100, reference: "Test", sender_id: 1, receiver_name: "Receiver", receiver_act: "Savings ISA", sender_name: "Sender"}, user_id: user.id}
            expect(assigns[:transaction].reference).to eq("Test")
        end
    end
end