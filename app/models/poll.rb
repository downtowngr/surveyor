class Poll < ActiveRecord::Base
  has_many :poll_choices
  
  validates :name, presence: true
end
