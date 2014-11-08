class Poll < ActiveRecord::Base
  VOTING_STRATEGIES = ['SingleVoteStrategy', 'MultipleChoiceStrategy']
  
  has_many :poll_choices
  has_many :dispatches
  
  validates :name, presence: true
end
