require "rails_helper"

RSpec.describe ProcessInboundText do
  describe "#call" do
    let!(:text) { Text.new({"From" => "+16165551234", "Body" => "VISION"}) }
    let!(:citizen) { create(:citizen, phone_number: "16165551234") }

    context "when incoming text is from number listened for" do
      let!(:number_listener) { create(:number_listener, number: "16165551234") }

      it "calls #respond_to on NumberListener" do
        expect(number_listener).to receive(:respond_to).with(text, citizen)

        NumberListener.stub(:find_by).with({number: citizen.phone_number})
                                     .and_return(number_listener)

        ProcessInboundText.call(citizen: citizen, text: text)
      end
    end

    context "when incoming text is not from number listened for" do
      let!(:keyword_listener) { create(:keyword_listener, keyword: "vision") }

      it "calls #respond_to on KeywordListener" do
        expect(keyword_listener).to receive(:respond_to).with(text, citizen)

        NumberListener.stub(:find_by).with({number: citizen.phone_number}).and_return(nil)
        KeywordListener.stub(:find_by_text).with(text).and_return(keyword_listener)

        ProcessInboundText.call(citizen: citizen, text: text)
      end
    end
  end
end
