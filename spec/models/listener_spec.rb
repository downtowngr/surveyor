require 'rails_helper'

RSpec.describe Listener, type: :model do
  describe "process_text" do
    # dispatch create is triggered by poll_choice creation
    let(:poll_choice) { create(:poll_choice) }
    let(:citizen) { create(:citizen) }

    it "should pass the text message to the poll strategy" do
      listener = Listener.find_by(keyword: poll_choice.name)
      text = Text.new({"From" => "", "Body" => ""})

      expect(listener.poll.strategy.constantize).to receive(:process_text)

      listener.trigger(text, citizen)
    end
  end
end
