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

        it "GET index open tickets" do
            get :index, params: { status: "Open" }
            expect(response).to be_successful
        end
    end

    context "as an approved user" do
        let(:approved_organization) { create(:organization, :approved) }
        let(:user) { create(:user, :confirmed, organization: approved_organization) }

        before(:each) do
            sign_in(user)
        end

        it "GET index" do
            get :index
            expect(response).to be_successful
        end

        it "GET index open tickets" do
            get :index, params: { status: "Open" }
            expect(response).to be_successful
        end

        it "GET index mycaptured tickets" do
            get :index, params: { status: "My Captured" }
            expect(response).to be_successful
        end

        it "GET index myclosed tickets" do
            get :index, params: { status: "My Closed" }
            expect(response).to be_successful
        end
    end

    context "as an admin" do
        let(:admin) { create(:user, :admin, :confirmed) }

        before(:each) do
            sign_in(admin)
        end

        it "GET index" do
            get :index
            expect(response).to be_successful
        end

        it "GET index open tickets" do
            get :index, params: { status: "Open" }
            expect(response).to be_successful
        end

        it "GET index captured tickets" do
            get :index, params: { status: "Captured" }
            expect(response).to be_successful
        end

        it "GET index closed tickets" do
            get :index, params: { status: "Closed" }
            expect(response).to be_successful
        end
    end
end
