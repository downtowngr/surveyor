require "rails_helper"

RSpec.describe MultipleChoiceStrategy, type: :model do
  describe "#process_text" do
    let(:poll) { create(:poll, strategy: "MultipleVoteStrategy") }
    let(:poll_choice1) { create(:poll_choice, poll: poll) }
    let(:poll_choice2) { create(:poll_choice, poll: poll) }
    let(:text1) { Text.new({"From" => "1234567890", "Body" => "#{poll_choice1.name}"}) }
    let(:text2) { Text.new({"From" => "1234567890", "Body" => "#{poll_choice2.name}"}) }

    let(:citizen) { create(:citizen, phone_number: text1.from) }

    describe "when a citizen votes twice for the same choice" do
      it "should not increment the vote" do
        expect { MultipleChoiceStrategy.process_text(poll, text1) }.to change { poll_choice1.votes.count }.by(1)
        expect { MultipleChoiceStrategy.process_text(poll, text1) }.not_to change { poll_choice1.votes.count }
      end
    end

    describe "when a citizen votes for different choices" do
      it "should increment the votes for both" do
        expect { MultipleChoiceStrategy.process_text(poll, text1) }.to change { poll_choice1.votes.count }.by(1)
        expect { MultipleChoiceStrategy.process_text(poll, text2) }.to change { poll_choice2.votes.count }.by(1)
      end
    end
  end
end
