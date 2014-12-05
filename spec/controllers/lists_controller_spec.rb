require "rails_helper"

RSpec.describe ListsController, type: :controller do
  describe "#create", vcr: {cassette_name: :dummy_data} do
    it "creates a list with imported citizens" do
    end
  end
end
