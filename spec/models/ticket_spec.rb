require 'rails_helper'
include TicketsHelper

RSpec.describe Ticket, type: :model do
    let(:ticket) { Ticket.new }

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
        ticket.id = 1234
        expect(ticket.to_s).to eq("Ticket 1234")
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
