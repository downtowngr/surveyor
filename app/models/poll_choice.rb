class PollChoice < ActiveRecord::Base
  belongs_to :poll
  has_many :votes
  has_many :citizens, through: :votes

  after_create do
    poll.dispatches.create(keyword: name)
  end
end
