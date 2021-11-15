require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let(:user) {FactoryBot.create(:user)}
    ##### CREATE #####
    describe "POST create" do
        it "assigns user" do
            post :create, params: {user: {first_name: "Alex", last_name: "Holmes", username: "user1", password:"user1"}}
            expect(assigns[:user].username).to eq("user1")
        end
        context "user successfuly saves" do
            it "creates a user in the database" do
                post :create, params: {user: {first_name: "Alex", last_name: "Holmes", username: "user1", password:"user1"}}
                first_user = User.last
                expect(first_user.first_name).to eq("Alex")
                expect(first_user.last_name).to eq("Holmes")
                expect(first_user.username).to eq("user1")
            end
            it "creates a session" do
                post :create, params: {user: {first_name: "Alex", last_name: "Holmes", username: "user1", password:"user1"}}
                expect(session[:user_id]).to eq(User.last.id)
            end
            it "sets a flash message" do
                post :create, params: {user: {first_name: "Alex", last_name: "Holmes", username: "user1", password:"user1"}}
                expect(flash[:success]).to eq("Account Created")
            end
            it "redirects to root path" do
                post :create, params: {user: {first_name: "Alex", last_name: "Holmes", username: "user1", password:"user1"}}
                expect(response).to redirect_to root_path
             
            end
        end
        context "user doesn't save" do
            it "sets a flash message" do
                post :create, params: {user: {last_name: "Holmes", username: "user1", password:"user1"}}
                expect(flash[:notice]).to eq("Account was not created")
            end
            it "renders users#new" do
                post :create, params: {user: {last_name: "Holmes", username: "user1", password:"user1"}}
                expect(response).to render_template :new
            end
            it "does not create a session" do
                post :create, params: {user: {last_name: "Holmes", username: "user1", password:"user1"}}
                expect(session[:user_id]).to eq(nil)
            end
        end
    end

    ###### SHOW ######
    describe "GET show" do
        before do
            session[:user_id] = user.id
        end
        it "identifies correct user" do
            get :show,  params: {id: user.id}
            expect(assigns[:user].username).to eq("user1")
        end
        it "redirects to show path" do
            get :show,  params: {id: user.id}
            expect(response).to render_template :show
        end
    end

    ###### NEW_TRANSACTION ####### NOT WORKING
    describe "GET new_transaction" do
        it "redirects to new user trasaction" do
            user = FactoryBot.create(:user)
            session[:user_id] = user.id
            get :new_user_transaction, params: {id: user.id}
            expect(response).to redirect_to new_user_transaction(user.id) 
        end
    end
       
end