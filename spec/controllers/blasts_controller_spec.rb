require "rails_helper"

RSpec.describe BlastsController, type: :controller do
  describe "POST create" do
    let(:list) { create(:list) }
    it "saves a blast" do
      expect { post :create, blast: attributes_for(:blast, list_id: list.id) }.to change { Blast.count }.by(1)
    end

    it "calls SendBlastToList" do
      expect(SendBlastToList).to receive(:perform_async)
      post :create, blast: attributes_for(:blast, list_id: list.id, message: "Run!")
    end
  end
end
