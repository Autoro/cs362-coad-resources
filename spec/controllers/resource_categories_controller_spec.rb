require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
    let(:resource_category) { create(:resource_category) }

    context "as non-user" do
        it "GET index" do
            get :index
            expect(response).to redirect_to(new_user_session_path)
        end
        
        it "GET show" do
            get :show, params: { id: resource_category.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET new" do
            get :new
            expect(response).to redirect_to(new_user_session_path)
        end

        it "POST create" do
            post :create, params: { resource_category: attributes_for(:resource_category) }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "GET edit" do
            get :edit, params: { id: resource_category.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "PATCH update" do
            patch :update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "PATCH activate" do
            patch :activate, params: { id: resource_category.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "PATCH deactivate" do
            patch :deactivate, params: { id: resource_category.id }
            expect(response).to redirect_to(new_user_session_path)
        end

        it "DELETE destroy" do
            delete :destroy, params: { id: resource_category.id }
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
            get :show, params: { id: resource_category.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET new" do
            get :new
            expect(response).to redirect_to(dashboard_path)
        end

        it "POST create" do
            post :create, params: { resource_category: attributes_for(:resource_category) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "GET edit" do
            get :edit, params: { id: resource_category.id }
            expect(response).to redirect_to(dashboard_path)
        end
        
        it "PATCH update" do
            patch :update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PATCH activate" do
            patch :activate, params: { id: resource_category.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "PATCH deactivate" do
            patch :deactivate, params: { id: resource_category.id }
            expect(response).to redirect_to(dashboard_path)
        end

        it "DELETE destroy" do
            delete :destroy, params: { id: resource_category.id }
            expect(response).to redirect_to(dashboard_path)
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

        it "GET show" do
            get :show, params: { id: resource_category.id }
            expect(response).to be_successful
        end

        it "GET new" do
            get :new
            expect(response).to be_successful
        end

        it "POST create success" do
            post :create, params: { resource_category: attributes_for(:resource_category) }
            expect(response).to redirect_to(resource_categories_path)
        end

        it "POST create failure" do
            allow_any_instance_of(ResourceCategory).to receive(:save).and_return(false)

            post :create, params: { resource_category: attributes_for(:resource_category) }
            expect(response).to render_template(:new)
        end

        it "GET edit" do
            get :edit, params: { id: resource_category.id }
            expect(response).to render_template(:edit)
        end
        
        it "PATCH update success" do
            patch :update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) }
            expect(response).to redirect_to(resource_category)
        end

        it "PATCH update failure" do
            allow_any_instance_of(ResourceCategory).to receive(:save).and_return(false)

            patch :update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) }
            expect(response).to render_template(:edit)
        end

        it "PATCH activate success" do
            patch :activate, params: { id: resource_category.id }
            expect(response).to redirect_to(resource_category)
        end

        it "PATCH activate failure" do
            allow_any_instance_of(ResourceCategory).to receive(:activate).and_return(false)
            
            patch :activate, params: { id: resource_category.id }
            expect(response).to redirect_to(resource_category)
        end

        it "PATCH deactivate success" do
            patch :deactivate, params: { id: resource_category.id }
            expect(response).to redirect_to(resource_category)
        end

        it "PATCH deactiveate failure" do
            allow_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(false)

            patch :deactivate, params: { id: resource_category.id }
            expect(response).to redirect_to(resource_category)
        end

        it "DELETE destroy success" do
            delete :destroy, params: { id: resource_category.id }
            expect(response).to redirect_to(resource_categories_path)
        end

        it "DELETE destroy failure" do
            allow_any_instance_of(DeleteResourceCategoryService).to receive(:run!).and_return(false)

            delete :destroy, params: { id: resource_category.id }
            expect(response).to redirect_to(resource_categories_path)
        end
    end
end
