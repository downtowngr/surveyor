require "rails_helper"

RSpec.describe SendBlastToList do
  describe "#perform" do
    let(:citizen1) { create(:citizen) }
    let(:citizen2) { create(:citizen) }
    let(:list) { create(:list, citizens: [citizen1, citizen2]) }
    let(:blast) { create(:blast, list: list, message: "Oh") }

    it "queues twilio outbound for all citizens" do
      expect(TwilioOutbound).to receive(:perform_async)
                            .with(citizen1.phone_number, "Oh")
      expect(TwilioOutbound).to receive(:perform_async)
                            .with(citizen2.phone_number, "Oh")

      SendBlastToList.new.perform(blast.id)
    end

    context "blast has question" do
      let!(:question) { create(:question, blast: blast) }

      it "sends question" do
        Blast.stub(:find).with(blast.id).and_return(blast)

        expect(blast).to receive(:send_question).with(citizen1)
        expect(blast).to receive(:send_question).with(citizen2)

        SendBlastToList.new.perform(blast.id)
      end
    end

    context "blast has no question" do
      it "does not send question" do
        Blast.stub(:find).with(blast.id).and_return(blast)

        expect(blast).not_to receive(:send_question).with(citizen1)
        expect(blast).not_to receive(:send_question).with(citizen2)

        SendBlastToList.new.perform(blast.id)
      end
    end
  end
end
