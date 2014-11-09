class Poll < ActiveRecord::Base
  VOTING_STRATEGIES = ['SingleVoteStrategy', 'MultipleChoiceStrategy']
  
  has_many :poll_choices, dependent: :destroy
  has_many :dispatches, dependent: :destroy
  
  validates :name, presence: true
  validates :strategy, presence: true
end
