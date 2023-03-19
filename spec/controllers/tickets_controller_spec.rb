require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
    let(:region) { create(:region) }
    let(:resource_category) { create(:resource_category) }
    let(:ticket) { create(:ticket, resource_category: resource_category, region: region) }

    context "as a non-user" do
        it "GET new" do
            get :new
            expect(response).to be_successful
        end

        it "POST create success" do
            post :create, params: { ticket: attributes_for(:ticket) }
            expect(response).to be_successful
        end

        it "POST create failure" do
            allow_any_instance_of(Ticket).to receive(:save).and_return(false)

            post :create, params: { ticket: attributes_for(:ticket) }
            expect(response).to render_template(:new)
        end

        it "GET show" do
            get :show, params: { id: ticket.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "POST capture" do
            post :capture, params: { id: ticket.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "POST release" do
            post :release, params: { id: ticket.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "PATCH close" do
            patch :close, params: { id: ticket.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "DELETE destroy" do
            delete :destroy, params: { id: ticket.id }
            expect(response).to redirect_to(new_user_session_path)
        end
    end

    context "as a user" do
        let(:user) { create(:user, :confirmed) }

        before(:each) do
            sign_in(user)
        end

        it "GET new" do
            get :new
            expect(response).to be_successful
        end

        it "POST create success" do
            post :create, params: { ticket: attributes_for(:ticket) }
            expect(response).to be_successful
        end

        it "POST create failure" do
            allow_any_instance_of(Ticket).to receive(:save).and_return(false)

            post :create, params: { ticket: attributes_for(:ticket) }
            expect(response).to render_template(:new)
        end

        it "GET show" do
            get :show, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "POST capture" do
            post :capture, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "POST release" do
            post :release, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PATCH close" do
            patch :close, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "DELETE destroy" do
            delete :destroy, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path)
        end
    end

    context "as an approved user" do
        let(:approved_organization) { create(:organization, :approved) }
        let(:user) { create(:user, :confirmed, organization: approved_organization) }
        let(:organization_ticket) { create(:ticket, organization: approved_organization, resource_category: resource_category, region: region) }

        before(:each) do
            sign_in(user)
        end

        it "GET show" do
            get :show, params: { id: ticket.id }
            expect(response).to be_successful
        end

        it "POST capture success" do
            post :capture, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path << "#tickets:open")
        end

        it "POST capture failure" do
            allow(TicketService).to receive(:capture_ticket).and_return(false)

            post :capture, params: { id: ticket.id }
            expect(response).to render_template(:show)
        end

        it "POST release success" do
            post :release, params: { id: organization_ticket.id }
            expect(response).to redirect_to(dashboard_path << "#tickets:organization")
        end

        it "POST release failure" do
            allow(TicketService).to receive(:release_ticket).and_return(false)

            post :release, params: { id: organization_ticket.id }
            expect(response).to render_template(:show)
        end

        it "PATCH close success" do
            patch :close, params: { id: organization_ticket.id }
            expect(response).to redirect_to(dashboard_path << "#tickets:organization")
        end

        it "PATCH close failure" do
            allow(TicketService).to receive(:close_ticket).and_return(false)

            patch :close, params: { id: organization_ticket.id }
            expect(response).to render_template(:show)
        end
    end

    context "as an admin" do
        let(:user) { create(:user, :admin, :confirmed) }

        before(:each) do
            sign_in(user)
        end

        it "GET new" do
            get :new
            expect(response).to be_successful
        end

        it "POST create success" do
            post :create, params: { ticket: attributes_for(:ticket) }
            expect(response).to be_successful
        end

        it "POST create failure" do
            allow_any_instance_of(Ticket).to receive(:save).and_return(false)

            post :create, params: { ticket: attributes_for(:ticket) }
            expect(response).to render_template(:new)
        end

        it "GET show" do
            get :show, params: { id: ticket.id }
            expect(response).to be_successful
        end

        it "POST capture" do
            post :capture, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "POST release" do
            post :release, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PATCH close success" do
            patch :close, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path << "#tickets:open")
        end

        it "PATCH close failure" do
            allow(TicketService).to receive(:close_ticket).and_return(false)

            patch :close, params: { id: ticket.id }
            expect(response).to render_template(:show)
        end

        it "DELETE destroy" do
            delete :destroy, params: { id: ticket.id }
            expect(response).to redirect_to(dashboard_path << "#tickets")
        end
    end
end
