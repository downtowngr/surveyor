require 'rails_helper'

RSpec.describe Dispatch, type: :model do
  describe "process_text" do
    # dispatch create is triggered by poll_choice creation
    let(:poll_choice) { create(:poll_choice) }
    
    it "should pass the text message to the poll strategy" do
      dispatch = Dispatch.find_by(keyword: poll_choice.name)
      text = Text.new({"From" => "", "Body" => ""})
      expect(dispatch.poll.strategy.constantize).to receive(:process_text)
      
      dispatch.process_text(text)
    end
  end
end
