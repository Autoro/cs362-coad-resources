require 'rails_helper'

RSpec.describe RegionsController, type: :controller do
    let(:region) { create(:region) }
    
    context "as a non-user" do
        it "GET index" do
            get :index
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET show" do
            get :show, params: { id: region.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET new" do
            get :new
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET create" do
            get :create, params: { region: attributes_for(:region) }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET edit" do
            get :edit, params: { id: region.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "PATCH update" do
            patch :update, params: { id: region.id, region: attributes_for(:region) }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "PUT update" do
            put :update, params: { id: region.id, region: attributes_for(:region) }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "DELETE destroy" do
            delete :destroy, params: { id: region.id }
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
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET show" do
            get :show, params: { id: region.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET new" do
            get :new
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET edit" do
            get :edit, params: { id: region.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET create" do
            get :create, params: { region: attributes_for(:region) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PATCH update" do
            patch :update, params: { id: region.id, region: attributes_for(:region) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PUT update" do
            put :update, params: { id: region.id, region: attributes_for(:region) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "DELETE destroy" do
            delete :destroy, params: { id: region.id }
            expect(response).to redirect_to(dashboard_path)
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

        it "GET show" do
            get :show, params: { id: region.id }
            expect(response).to be_successful
        end

        it "GET new" do
            get :new
            expect(response).to be_successful
        end

        it "GET edit" do
            get :edit, params: { id: region.id }
            expect(response).to be_successful
        end

        it "GET create" do
            get :create, params: { region: attributes_for(:region) }
            expect(response).to redirect_to(regions_path)
        end

        it "PATCH update" do
            patch :update, params: { id: region.id, region: attributes_for(:region) }
            expect(response).to redirect_to(region_path(region.id))
        end

        it "PUT update" do
            put :update, params: { id: region.id, region: attributes_for(:region) }
            expect(response).to redirect_to(region_path(region.id))
        end

        it "DELETE destroy" do
            delete :destroy, params: { id: region.id }
            expect(response).to redirect_to(regions_path)
        end
    end
end
