class MultipleChoiceStrategy
  def self.process_text(new_choice, current_choices, text, citizen)
    already_voted = current_choices.where(id: new_choice.id)

    if already_voted.empty?
      new_choice.votes.create(citizen_id: citizen.id)
      text.respond_with = "You've voted for #{new_choice.name}"
    else
      text.respond_with = "Sorry, you can't vote for #{already_voted.first.name} more then once."
    end
  end
end
