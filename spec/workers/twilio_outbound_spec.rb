require "rails_helper"

RSpec.describe TwilioOutbound do
  describe "#perform" do
    it "sends an SMS through Twilio" do
      messages = double(:messages)
      twilio   = double(:twilio, messages: messages)

      expect(messages).to receive(:create).with({from: Figaro.env.twilio_number,
                                                 to: "+16165551234",
                                                 body: "Friends!"})

      expect(Twilio::REST::Client).to receive(:new)
                                     .with(Figaro.env.twilio_account_sid, Figaro.env.twilio_auth_token)
                                     .and_return(twilio)

      TwilioOutbound.new.perform("16165551234", "Friends!")
    end
  end
end
