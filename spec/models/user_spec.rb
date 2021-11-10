require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'checking the validity of a user' do
        it "creates a user when all data is correctly set" do
            user = FactoryBot.create(:user)
            expect(user.save).to eq(true)
        end

        it { should validate_presence_of(:first_name) }

    end
end