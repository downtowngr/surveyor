require "rails_helper"

RSpec.describe Event, :type => :model do
  describe "#respond_to" do
    let(:event) { create(:event, autoresponse: "Thanks!") }
    let(:citizen) { create(:citizen) }
    let(:text) { Text.new({"From" => "+16161235555", "Body" => "movies"}) }

    context "when a user has not checked in" do
      it "returns custom autoresponse" do
        event.respond_to(text, citizen)
        expect(text.respond_with).to eq(event.autoresponse)
      end

      it "creates check in" do
        expect { event.respond_to(text, citizen) }.to change { event.check_ins.count }.by(1)
      end
    end

    context "when a user has already checked in" do
      before do
        create(:check_in, citizen: citizen, event: event)
      end

      it "returns autoresponse" do
        event.respond_to(text, citizen)
        expect(text.respond_with).to eq("I love your enthusiasm! You've already checked in to #{event.name}.")
      end

      it "does not create another check in" do
        expect { event.respond_to(text, citizen) }.not_to change { event.check_ins.count }
      end
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

  describe "listener" do
    let(:event) { create(:event, keyword: "come") }
    let!(:listener) { event.listener }

    it "destroys listener when deleted" do
      expect { event.destroy }.to change { Listener.count }.by(-1)
    end

    it "creates listener when created" do
      expect(event.listener).not_to be nil
    end

    it "updates listener when keyword is changed" do
      expect(listener.keyword).to eq("COME")
      event.keyword = "alone"
      event.save
      expect(listener.keyword).to eq("ALONE")
    end
  end
end
