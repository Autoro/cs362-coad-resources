require 'rails_helper'

RSpec.describe Region, type: :model do
  let(:region) { build_stubbed(:region) }

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "returns its name as a string" do
    expect(region.to_s).to eq(region.name)
  end

  it "returns a Region with the name 'Unspecified'" do
    expect(Region.unspecified.name).to eq("Unspecified")
  end

  it { should have_many(:tickets) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }

  it { should validate_uniqueness_of(:name).case_insensitive }
end
