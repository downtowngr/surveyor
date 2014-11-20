require "rails_helper"

def params(body="text")
  {"From" => "+16165555555", "Body" => body }
end

RSpec.describe Text, type: :model do
  let(:text) { Text.new(params) }

  describe "#new" do

    it "sets @from to be 10 digits" do
      expect(text.number).to eq("6165555555")
    end

    it "sets @body" do
      expect(text.body).to eq("text")
    end

    it "sets keyword if it fits keyword rules" do
      expect(text.keyword).to eq("TEXT")

      text = Text.new(params("#hashtagz"))
      expect(text.keyword).to eq("#HASHTAGZ")

      text = Text.new(params("$stuff"))
      expect(text.keyword).to be_nil

      text = Text.new(params("text@example.com"))
      expect(text.keyword).to be_nil

      text = Text.new(params("more words"))
      expect(text.keyword).to be_nil
    end
  end

  describe "#keyword?" do
    it "returns true if there is a keyword" do
      expect(text.keyword?).to be true
    end

    it "returns false if there is no keyword" do
      text.keyword = nil
      expect(text.keyword?).to be false
    end
  end
end

