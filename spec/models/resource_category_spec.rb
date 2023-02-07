require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
    let(:resource_category) { build_stubbed(:resource_category) }
    let(:active_resource_category) { create(:resource_category, active: true) }
    let(:inactive_resource_category) { create(:resource_category, active: false) }

    it "has a name" do
        expect(resource_category).to respond_to(:name)
    end

    it "has an active" do
        expect(resource_category).to respond_to(:active)
    end

    it "is activatable" do
        inactive_resource_category.activate
        expect(inactive_resource_category).to_not be_inactive
    end

    it "is deactivatable" do
        active_resource_category.deactivate
        expect(active_resource_category).to be_inactive
    end

    it "returns its current status" do
        expect(resource_category.inactive?).to_not be_nil
    end

    it "returns its name as a string" do
        expect(resource_category.to_s).to eq(resource_category.name)
    end

    it "returns a ResourceCategory with the name 'Unspecified'" do
        expect(ResourceCategory.unspecified.name).to eq("Unspecified")
    end

    it "returns a set of active resource categories" do
        expect(ResourceCategory.active).to include(active_resource_category)
    end

    it "returns a set of inactive resource categories" do
        expect(ResourceCategory.inactive).to include(inactive_resource_category)
    end

    it { should have_and_belong_to_many(:organizations) }

    it { should have_many(:tickets) }

    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }

    it { should validate_uniqueness_of(:name).case_insensitive }
end
