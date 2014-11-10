class Poll < ActiveRecord::Base
  # TODO: Cannot change poll strategy in the middle of polling

  VOTING_STRATEGIES = ['SingleVoteStrategy', 'MultipleChoiceStrategy']

  has_many :poll_choices, dependent: :destroy
  has_many :votes, through: :poll_choices
  has_many :dispatches, dependent: :destroy

  validates :name, presence: true
  validates :strategy, presence: true

  def process_vote(text, citizen)
    new_choice = poll_choices.find_by(name: text.keyword)
    current_choices = citizen.current_votes(self)

    strategy.constantize.process_text(new_choice, current_choices, text, citizen)
  end
end
