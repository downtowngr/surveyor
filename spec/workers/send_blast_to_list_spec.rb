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
  end
end
