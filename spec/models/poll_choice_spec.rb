require 'rails_helper'

RSpec.describe PollChoice, :type => :model do
  let(:poll) { create(:poll) }

  it "should create a dispatch as it is created" do
    expect { create(:poll_choice, poll: poll) }.to change { poll.keyword_listeners.count }.by(1)
  end
end
