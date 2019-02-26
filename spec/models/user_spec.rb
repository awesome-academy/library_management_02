require "rails_helper"
require "spec_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it {is_expected.to have_many( :likes).dependent :destroy}
    it {is_expected.to have_many( :comments).dependent :destroy}
    it {is_expected.to have_many( :borrows).dependent :destroy}
  end

  describe "validations" do
    it { should validate_presence_of :full_name }
  end

  describe "role's enumerations" do
    it "should be either user or admin" do
      is_expected.to define_enum_for(:role).with_values [:user, :admin]
    end
  end
end
