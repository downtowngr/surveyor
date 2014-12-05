require "rails_helper"

RSpec.describe ListsController, type: :controller do
  describe "#create" do
    use_vcr_cassette :dummy_data

    it "creates a list with imported citizens" do
    end
  end
end
