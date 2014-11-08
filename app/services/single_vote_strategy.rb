class SingleVoteStrategy
  def self.process_text(poll, text)
    choice = poll.poll_choices.find_by(name: text.keyword)
    citizen = Citizen.find_or_create_by(phone_number: text.from)
    choice.votes.create(citizen: citizen)
  end
end
