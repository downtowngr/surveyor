class SingleVoteStrategy
  def self.process_text(poll, text)
    choice = poll.poll_choices.find_by(name: text.keyword)
    citizen = Citizen.find_or_create_by(phone_number: text.from)

    # Check if this citizen has already voted
    current_vote = choice.votes.where(ci
    choice.votes.create(citizen_id: citizen.id)
  end
end
