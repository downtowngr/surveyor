require 'rails_helper'

RSpec.describe SingleVoteStrategy, type: :model do
  let(:poll_choice) { create(:poll_choice) }
  let(:poll) { poll_choice.poll }
  let(:text) { t = Text.new({"From" => "1234567890", "Body" => "#{poll_choice.name}"}) }
  let!(:citizen) { create(:citizen, phone_number: text.from) }

  describe "#process_text" do
    describe "when a new citizen votes" do
      it "should create a new vote" do
        expect { SingleVoteStrategy.process_text(poll, text, citizen) }.to change { poll_choice.votes.count }.by(1)
      end
    end

    describe "when an existing citizen votes" do
      it "should create a new vote" do
        expect { SingleVoteStrategy.process_text(poll, text, citizen) }.to change { poll_choice.votes.count }.by(1)
      end
    end

    describe "when a citizen votes for the same choice" do
      it "should not increment the votes" do
        create(:vote, poll_choice: poll_choice, citizen: citizen)
        expect { SingleVoteStrategy.process_text(poll, text, citizen) }.not_to change { poll_choice.votes.count }
      end
    end

    describe "when a citizen votes for a different choice" do
      let!(:poll_choice2) { create(:poll_choice, poll: poll) }

      it "should change the vote" do
        create(:vote, poll_choice: poll_choice2, citizen: citizen)

        expect(poll_choice.votes.count).to eq(0)
        expect(poll_choice2.votes.count).to eq(1)

        SingleVoteStrategy.process_text(poll, text, citizen)

        expect(poll_choice.votes.count).to eq(1)
        expect(poll_choice2.votes.count).to eq(0)
      end
    end
  end
end
