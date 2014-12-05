require "rails_helper"

def params(body="text")
  {"From" => "+16165555555", "Body" => body }
end

RSpec.describe Text, type: :model do
  let(:text) { Text.new(params) }

  describe "#new" do

    it "sets number to national phone" do
      expect(text.number).to eq("16165555555")
    end

    it "sets @body" do
      expect(text.body).to eq("text")
    end
  end
end

