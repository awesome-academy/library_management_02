require "rails_helper"
require "spec_helper"

RSpec.describe Borrow, type: :model do
  context "associations" do
    it {is_expected.to have_many( :borrow_details).dependent :destroy}
    it {is_expected.to have_many( :books).dependent :destroy}
  end
  context "validates" do
    it {is_expected.to validate_presence_of :date_borrow}
    it {is_expected.to validate_presence_of :end_date_borrow}
  end
end
