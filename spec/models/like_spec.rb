require "rails_helper"
require "spec_helper"

RSpec.describe Like, type: :model do
  context "associations" do
    it {is_expected.to belong_to :book}
    it {is_expected.to belong_to :user}
  end
  context "validates" do
  end
end
