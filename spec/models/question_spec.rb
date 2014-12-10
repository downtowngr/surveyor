require "rails_helper"

RSpec.describe Question, type: :model do
  let!(:question) { create(:question, citizen_attribute: "email",
                           prompt: "Email:", autoresponse: "Thanks!",
                           nationbuilder_tags: ["Send-Email"]) }

  let!(:citizen) { create(:citizen, phone_number: "16165551234") }

  describe "#respond_to" do
    context "when email is valid" do
      it "sets citizen_attribute and nationbuilder tags on citizen" do
        text = Text.new({"Body"=>"dude@example.us", "From"=>"16165551234"})

        expect(citizen).to receive(:sync_to_nationbuilder!)
        expect(question).to receive(:destroy_listener).with(citizen)

        question.respond_to(text, citizen)
        expect(citizen.email).to eq("dude@example.us")
        expect(citizen.nationbuilder_tags).to eq(["Send-Email"])
        expect(text.respond_with).to eq("Thanks!")
      end

      it "sets citizen_attribute and nationbuilder tags on citizen" do
        text = Text.new({"Body"=>"  dude@example.us ", "From"=>"16165551234"})

        expect(citizen).to receive(:sync_to_nationbuilder!)
        expect(question).to receive(:destroy_listener).with(citizen)

        question.respond_to(text, citizen)
        expect(citizen.email).to eq("dude@example.us")
        expect(citizen.nationbuilder_tags).to eq(["Send-Email"])
        expect(text.respond_with).to eq("Thanks!")
      end
    end

    context "when email is invalid" do
      it "responds with email error message" do
        text = Text.new({"Body"=>"dude@example", "From"=>"16165551234"})

        expect(citizen).not_to receive(:sync_to_nationbuilder!)
        expect(question).not_to receive(:destroy_listener)

        question.respond_to(text, citizen)
        expect(text.respond_with).to eq("Sorry, that doesn't look like an email. Please try again. :)")
      end

      it "response with email error message" do
        text = Text.new({"Body"=>"what", "From"=>"16165551234"})

        expect(citizen).not_to receive(:sync_to_nationbuilder!)
        expect(question).not_to receive(:destroy_listener)

        question.respond_to(text, citizen)
        expect(text.respond_with).to eq("Sorry, that doesn't look like an email. Please try again. :)")
      end
    end
  end

  describe "#create_listener" do
    it "creates listener for citizen's number" do
      expect {
        question.create_listener(citizen)
      }.to change {
        question.number_listeners.count
      }.from(0).to(1)

      listener = question.number_listeners.first

      expect(listener.number).to eq("16165551234")
    end
  end

  describe "#destroy_listener" do
    it "destroys listener for citizen's number" do
      NumberListener.create(number: citizen.phone_number, listening: question)

      expect {
        question.destroy_listener(citizen)
      }.to change {
        question.number_listeners.count
      }.from(1).to(0)
    end
  end
end
