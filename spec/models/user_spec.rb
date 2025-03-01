require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { build_stubbed(:user) }

    it "has an email" do
        expect(user).to respond_to(:email)
    end

    it "has a role" do
        expect(user).to respond_to(:role)
    end

    it "sets a default role if one does not exist" do
        user.set_default_role
        expect(user.role).to_not be_nil
    end
    it "returns its email as a string" do
        expect(user.to_s).to eq(user.email)
    end
    
    it { should belong_to(:organization).optional }

    it { should validate_presence_of(:email) }

    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }

    it { should allow_value("foo@bar.com").for(:email) }

    it { should_not allow_value("asdf").for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password).on(:create) }

    it { should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }
end
