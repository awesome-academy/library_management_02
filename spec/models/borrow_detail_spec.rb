require "rails_helper"
require "spec_helper"

RSpec.describe BorrowDetail, type: :model do
  context "associations" do
    it {is_expected.to belong_to :borrow}
    it {is_expected.to belong_to :book}
  end
  context "validates" do
    it {is_expected.to validate_presence_of :number}
  end
end
