require 'rails_helper'

RSpec.describe Listener, type: :model do
  describe "trigger" do
    let(:text) { double(:text) }
    let(:citizen) { double(:citizen) }
    let(:poll) { create(:poll) }

    let(:listener) { create(:listener, listening: poll) }

    it "calls #trigger with text and citizen object on listening" do
      expect(poll).to receive(:respond_to).with(text, citizen)
      listener.trigger(text, citizen)
    end
  end
end
