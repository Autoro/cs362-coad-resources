require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
    let(:organization) { create(:organization) }

    context "as a non-user" do
        it "GET index" do
            get :index
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET new" do
            get :new
            expect(response).to redirect_to(new_user_session_path)
        end

        it "POST create" do
            post :create, params: { organization: attributes_for(:organization) }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET edit" do
            get :edit, params: { id: organization.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "PATCH update" do
            patch :update, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(new_user_session_path)
        end
        
        it "PUT update" do
            put :update, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET show" do
            get :show, params: { id: organization.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "POST approve" do
            post :approve, params: { id: organization.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "POST reject" do
            post :reject, params: { id: organization.id }
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

        it "GET new" do
            get :new
            expect(response).to be_successful
        end

        it "POST create" do
            create(:user, :admin, :confirmed)

            post :create, params: { organization: attributes_for(:organization) }
            expect(response).to redirect_to(organization_application_submitted_path)
        end

        it "POST create failure" do
            allow_any_instance_of(Organization).to receive(:save).and_return(false)

            post :create, params: { organization: attributes_for(:organization) }
            expect(response).to render_template(:new)
        end

        it "GET edit" do
            get :edit, params: { id: organization.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PATCH update" do
            patch :update, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PUT update" do
            put :update, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET show" do
            get :show, params: { id: organization.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "POST approve" do
            post :approve, params: { id: organization.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "POST reject" do
            post :reject, params: { id: organization.id }
            expect(response).to redirect_to(dashboard_path)
        end
    end

    context "as an approved user" do
        let(:approved_organization) { create(:organization, :approved) }
        let(:user) { create(:user, :confirmed, organization: approved_organization) }

        before(:each) do
            sign_in(user)
        end

        it "GET edit" do
            get :edit, params: { id: approved_organization.id }
            expect(response).to be_successful
        end

        it "PATCH update success" do
            patch :update, params: { id: approved_organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(organization_path(id: approved_organization.id))
        end

        it "PATCH update failure" do
            allow_any_instance_of(Organization).to receive(:update).and_return(false)

            patch :update, params: { id: approved_organization.id, organization: attributes_for(:organization) }
            expect(response).to render_template(:edit)
        end

        it "PUT update success" do
            put :update, params: { id: approved_organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(organization_path(id: approved_organization.id))
        end

        it "PUT update failure" do
            allow_any_instance_of(Organization).to receive(:update).and_return(false)

            put :update, params: { id: approved_organization.id, organization: attributes_for(:organization) }
            expect(response).to render_template(:edit)
        end

        it "GET show" do
            get :show, params: { id: approved_organization.id }
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

        it "GET new" do
            get :new
            expect(response).to redirect_to(dashboard_path)
        end

        it "POST create" do
            post :create, params: { organization: attributes_for(:organization) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET edit" do
            get :edit, params: { id: organization.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PATCH update" do
            patch :update, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PUT update" do
            put :update, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET show" do
            get :show, params: { id: organization.id }
            expect(response).to be_successful
        end

        it "POST approve success" do
            post :approve, params: { id: organization.id }
            expect(response).to redirect_to(organizations_path)
        end

        it "POST approve failure" do
            allow_any_instance_of(Organization).to receive(:save).and_return(false)

            post :approve, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(organization_path(id: organization.id))
        end

        it "POST reject success" do
            post :reject, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(organizations_path)
        end

        it "POST reject failure" do
            allow_any_instance_of(Organization).to receive(:save).and_return(false)

            post :reject, params: { id: organization.id, organization: attributes_for(:organization) }
            expect(response).to redirect_to(organization_path(id: organization.id))
        end
    end
end
