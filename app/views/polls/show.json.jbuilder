json.array! @poll.poll_choices do |poll_choice|
  json.name poll_choice.name
  json.votes poll_choice.votes.count
end
