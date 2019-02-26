require "rails_helper"
require "spec_helper"
RSpec.describe Category, type: :model do
  context "associations" do
    it {is_expected.to have_many( :books).dependent :destroy}
  end
  context "validates" do
    it {is_expected.to validate_presence_of :name}
  end
end
