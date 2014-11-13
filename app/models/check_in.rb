class CheckIn < ActiveRecord::Base
  belongs_to :event
  belongs_to :citizen

  validates :event, presence: true
  validates :citizen, presence: true
end
