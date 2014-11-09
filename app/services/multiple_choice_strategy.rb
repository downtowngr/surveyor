class MultipleChoiceStrategy
  def self.process_text(poll, text, citizen)
    new_choice = poll.poll_choices.find_by(name: text.keyword)
    current_choice = citizen.current_vote(poll)

    unless current_choice == new_choice
      new_choice.votes.create(citizen_id: citizen.id)
    end
  end
end
