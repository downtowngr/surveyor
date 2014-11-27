require "rails_helper"

RSpec.describe BlastsController, type: :controller do
  describe "POST create" do
    it "saves a blast" do
      expect { post :create, blast: attributes_for(:blast) }.to change { Blast.count }.by(1)
    end

    it "queues all outbound texts" do
      citizen = create(:citizen, phone_number: "6165551234")

      expect(TwilioOutbound).to receive(:perform_async).with("6165551234", "Run!")

      post :create, blast: attributes_for(:blast, citizen_ids: [citizen.id], message: "Run!")
    end
  end
end
