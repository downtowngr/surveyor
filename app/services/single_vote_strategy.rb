class SingleVoteStrategy
  def self.process_text(poll, text)
    citizen = Citizen.find_or_create_by(phone_number: text.from)

    new_choice = poll.poll_choices.find_by(name: text.keyword)
    current_choice = citizen.current_vote(poll)

    if !current_choice
      new_choice.votes.create(citizen: citizen)
    elsif current_choice != new_choice
      current_choice.votes.find_by(citizen: citizen).destroy
      new_choice.votes.create(citizen: citizen)
    end
  end
end
