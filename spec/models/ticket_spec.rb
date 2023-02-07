require 'rails_helper'
include TicketsHelper

RSpec.describe Ticket, type: :model do
    let(:ticket) { build_stubbed(:ticket, id: 1) }
    let(:region) { create(:region) }
    let(:organization) { create(:organization) }
    let(:resource_category) { create(:resource_category) }
    let(:open_ticket) { create(:ticket, resource_category: resource_category, region: region) }
    let(:open_organization_ticket) { create(:ticket, resource_category: resource_category, region: region, organization: organization) }
    let(:closed_organization_ticket) { create(:ticket, closed: true, resource_category: resource_category, region: region, organization: organization) }

    it "has a name" do
        expect(ticket).to respond_to(:name)
    end

    it "has a description" do
        expect(ticket).to respond_to(:description)
    end

    it "has a phone" do
        expect(ticket).to respond_to(:phone)
    end

    it "has a closed" do
        expect(ticket).to respond_to(:closed)
    end

    it "has a closed_at" do
        expect(ticket).to respond_to(:closed_at)
    end

    it "returns whether or not it's open" do
        expect(ticket.open?).to_not be_nil
    end

    it "returns whether or not it's captured" do
        expect(ticket.captured?).to_not be_nil
    end

    it "returns a string with its id" do
        expect(ticket.to_s).to eq("Ticket " + ticket.id.to_s)
    end

    it "returns a set of open tickets not belonging to an organization" do
        expect(Ticket.open).to include(open_ticket)
    end

    it "returns a set of closed tickets" do
        expect(Ticket.closed).to include(closed_organization_ticket)
    end

    it "returns a set of open tickets belonging to an organization" do
        expect(Ticket.all_organization).to include(open_organization_ticket)
    end

    it "returns a set of open tickets belonging to a specific organiation" do
        expect(Ticket.organization 1).to include(open_organization_ticket)
    end

    it "returns a set of closed tickets belonging to a specific organization" do
        expect(Ticket.closed_organization 1).to include(closed_organization_ticket)
    end

    it "returns a set of tickets belonging to a specific region" do
        expect(Ticket.region 1).to include(open_ticket)
    end

    it "returns a set of tickets belonging to a specific resource category" do
        expect(Ticket.resource_category 1).to include(open_ticket)
    end

    it { should belong_to(:region) }

    it { should belong_to(:resource_category) }

    it { should belong_to(:organization).optional }

    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }

    it { should validate_presence_of(:phone) }

    it { should allow_value(format_phone_number("555-555-5555")).for(:phone) }

    it { should_not allow_value(format_phone_number("1234")).for(:phone) }

    it { should validate_presence_of(:region_id) }

    it { should validate_presence_of(:resource_category_id) }

    it { should validate_length_of(:description).is_at_most(1020).on(:create) }
end
