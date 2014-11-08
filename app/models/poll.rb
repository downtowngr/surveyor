class Poll < ActiveRecord::Base
  validates :name, presence: true
end
