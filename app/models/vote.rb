class Vote < ActiveRecord::Base
  belongs_to :poll_choice
  belongs_to :citizen

  validates :poll_choice, presence: true
  validates :citizen, presence: true
end
