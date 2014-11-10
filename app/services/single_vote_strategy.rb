class SingleVoteStrategy
  def self.process_text(new_choice, current_choices, text, citizen)
    current_choice = current_choices.first

    if !current_choice
      new_choice.votes.create(citizen: citizen)
      text.respond_with = "You've voted for #{new_choice.name}"
    elsif current_choice != new_choice
      current_choice.votes.find_by(citizen: citizen).destroy
      new_choice.votes.create(citizen: citizen)
      text.respond_with = "We've changed your vote from #{current_choice.name} to #{new_choice.name}"
    else
      text.respond_with = "You've already voted for #{current_choice.name}"
    end
  end
end
