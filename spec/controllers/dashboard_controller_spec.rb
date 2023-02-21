require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
    context "as a non-user" do
        it "GET index" do
            get :index
            expect(response).to redirect_to(new_user_session_path)
        end
    end

    context "as a user" do
        let(:user) { create(:user, :confirmed) }

        before(:each) do
            sign_in(user)
        end
    
        it "GET index" do
            get :index
            expect(response).to be_successful
        end
    end

    context "as an admin" do
        let(:admin) { create(:user, :confirmed, :admin) }

        before(:each) do
            sign_in(admin)
        end

        it "GET index" do
            get :index
            expect(response).to be_successful
        end
    end
end
