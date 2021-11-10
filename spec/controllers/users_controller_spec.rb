require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
                puts User.all.count
            end
            it "creates a session" do
                
            end
            it "sets a flash message" do
            
            end
            it "redirects to root path" do
                
            end
        end
        context "user doesn't save" do
            it "sets a flash message" do
                
            end
            it "renders users#new" do
                
            end
            it "does not create a session" do
                
            end
        end
    end
end