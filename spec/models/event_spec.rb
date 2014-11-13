require "rails_helper"

RSpec.describe Event, :type => :model do
  describe "#respond_to" do
    let(:event) { create(:event, autoresponse: "Thanks!") }
    let(:citizen) { create(:citizen) }
    let(:text) { Text.new({"From" => "+16161235555", "Body" => "movies"}) }

    it "checks in a citizen that has not checked in" do
      expect { event.respond_to(text, citizen) }.to change { event.check_ins.count }.by(1)
      expect(text.respond_with).to eq(event.autoresponse)
    end

    it "returns autoresponse if the user has already checked in" do
      create(:check_in, citizen: citizen, event: event)
      event.respond_to(text, citizen)
      expect(text.respond_with).to eq("I love your enthusiasm! You've already checked in to #{event.name}.")
    end
  end

  describe "#autoresponse=" do
    let(:event) { create(:event, name: "Top Gun", keyword: "yellow") }

    it "parses liquid tags" do
      event.autoresponse = "Thanks for coming to {{name}} - {{keyword}}"
      expect(event.autoresponse).to eq("Thanks for coming to Top Gun - YELLOW")
    end

    it "handles empty strings fine" do
      event.autoresponse = ""
      expect(event.autoresponse).to eq("")
    end
  end
end
