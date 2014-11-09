class MultipleChoiceStrategy
  def self.process_text(poll, text)
    poll_choice = poll.poll_choices.find_by(name: text.keyword)
    citizen = Citizen.find_or_create_by(phone_number: text.from)
    poll_choice.votes.create(citizen_id: citizen.id)
  end
end
