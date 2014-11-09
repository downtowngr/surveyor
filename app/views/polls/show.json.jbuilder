json.array! @poll.poll_choices do |poll_choice|
  json.keyword poll_choice.keyword
  json.votes poll_choice.votes.count
end
