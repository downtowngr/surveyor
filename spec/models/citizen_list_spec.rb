require "rails_helper"

RSpec.describe CitizenList, type: :model do
  describe "when initialized with an array" do
    it "returns the correct strings" do
      citizen_list = CitizenList.new([1,2,3])
      url_encoded = citizen_list.url_encoded

      expect(url_encoded).to eq("BAhbCGkGaQdpCA==")
      expect(citizen_list.serialized).to eq("\x04\b[\bi\x06i\ai\b")

      expect(CitizenList.new(url_encoded).array).to eq([1,2,3])
    end
  end

  describe "when initialized with a string" do
    it "returns the correct array" do
      citizen_list = CitizenList.new("BAhbCGkHaQlpCw==")
      url_encoded = citizen_list.url_encoded

      expect(CitizenList.new(url_encoded).array).to eq([2,4,6])
    end
  end

  describe "when not initialized with a string or array" do
    it "raises an exception" do
      expect { CitizenList.new({"this" => "hash"}) }.to raise_exception
    end
  end
end
