require 'rails_helper'

RSpec.describe SingleVoteStrategy, type: :model do
  let(:poll_choice) { create(:poll_choice) }
  let(:poll) { poll_choice.poll }
  let(:text) { t = Text.new({"From" => "1234567890", "Body" => "#{poll_choice.name}"}) }
  
  describe "process text" do
    describe "when a new citizen votes" do
      it "should create a new vote" do
        expect { SingleVoteStrategy.process_text(poll, text) }.to change { poll_choice.votes.count }.by(1)
      end

      it "should create a new citizen" do
        expect { SingleVoteStrategy.process_text(poll, text) }.to change { Citizen.count }.by(1)
      end
    end

    describe "when an existing citizen votes" do
      let!(:citizen) { create(:citizen, phone_number: text.from) }
      
      it "should create a new vote" do
        expect { SingleVoteStrategy.process_text(poll, text) }.to change { poll_choice.votes.count }.by(1)
      end

      it "should not create a new citizen" do
        expect { SingleVoteStrategy.process_text(poll, text) }.not_to change { Citizen.count }
      end
    end
  end
end
