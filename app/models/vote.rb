class Vote < ActiveRecord::Base
  belongs_to :poll_choice
  belongs_to :citizen
end
