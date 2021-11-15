require 'rails_helper'
RSpec.describe AccountsController, type: :controller do
    let(:user) {FactoryBot.create(:user)}
    describe "POST create" do
        it "assigns account" do
            
            post :create, params: {account: {user_id: user.id, account_name: "Savings ISA", balance: 300000}, user_id: user.id}
            expect(assigns[:account].user_id).to eq(user.id)
        end
        context "account successfuly saves" do
            it "creates an account in the database" do
                post :create, params: {account: {user_id: user.id, account_name: "Savings ISA", balance: 300000}, user_id: user.id}
                account = Account.last
                expect(account.user_id).to eq(user.id)
                expect(account.account_name).to eq("Savings ISA")
                expect(account.balance).to eq(300000)
            end
            it "sets a flash message" do
                post :create, params: {account: {user_id: user.id, account_name: "Savings ISA", balance: 300000}, user_id: user.id}
                expect(flash[:success]).to eq("New Account Opened")
            end
            it "redirects to user_url" do
                post :create, params: {account: {user_id: user.id, account_name: "Savings ISA", balance: 300000}, user_id: user.id}
                expect(response).to redirect_to user_url(user.id)
            end
        end
        context "account does not save" do
            it "flashes an error" do
                post :create, params: {account: {user_id: user.id, account_name: "Savings ISA"}, user_id: user.id}
                expect(flash[:notice]).to eq("Account did not open")
            end
            it "renders new" do
                post :create, params: {account: {user_id: user.id, account_name: "Savings ISA"}, user_id: user.id}
                expect(response).to render_template :new
            end
        end
    end

    #### DELETE ####
    describe "DELETE destroy" do
        context "destroy is successful" do
            it "deletes an account in the database" do
                session[:user_id] = user.id
                account = FactoryBot.create(:account, user_id: user.id)
                expect do
                    delete :destroy, params: {user_id: user.id, id: account.id}
                end.to change(Account, :count).by(-1)
            end
            it "sets a flash message" do
                session[:user_id] = user.id
                account = FactoryBot.create(:account, user_id: user.id)
                delete :destroy, params: {user_id: user.id, id: account.id}
                expect(flash[:notice]).to eq("Account Deleted")
            end
            it "redirects to user_url" do
                
            end
        end
        context "destroy fails" do
            it "flashes an error" do
                session[:user_id] = user.id
                account = FactoryBot.create(:account, user_id: user.id)
                allow_any_instance_of(Account).to receive(:destroy).and_return(false)
                delete :destroy, params: {user_id: user.id, id: account.id}
                expect(flash[:danger]).to eq("Failed to delete account")
            end
        end
    end
end