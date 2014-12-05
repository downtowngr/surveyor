require 'rails_helper'

RSpec.describe KeywordListener, type: :model do
  describe "trigger" do
    let(:text) { create(:text, body: "hello") }
    let(:citizen) { double(:citizen) }
    let(:poll) { create(:poll) }

    let(:keyword_listener) { create(:keyword_listener, listening: poll) }

    describe ".respond_to" do
      xit "calls #respond_to with text and citizen object on listening" do
        expect(poll).to receive(:respond_to).with(text, citizen)
        KeywordListener.respond_to(text, citizen)
      end
    end
  end
end
