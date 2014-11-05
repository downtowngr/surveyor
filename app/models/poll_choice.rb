class PollChoice < ActiveRecord::Base
  belongs_to :keyword
  belongs_to :poll
end
