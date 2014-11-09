class SingleVoteStrategy
  def self.process_text(poll, text)
    poll_choice = poll.poll_choices.find_by(name: text.keyword)
    citizen = Citizen.find_or_create_by(phone_number: text.from)

    # Check if this citizen has already voted
    current_vote = Vote.where(citizen_id: citizen.id).includes(:poll_choice).where("poll_choice.poll_id = ?", poll.id).references(:poll_choice)

    # # Keep remove and add in a transaction to not lose the users vote
    # current_vote.destroy if current_vote.present?

    # Regardless, create the new vote
    poll_choice.votes.create(citizen_id: citizen.id)
  end
end