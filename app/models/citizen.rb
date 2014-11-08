class Citizen < ActiveRecord::Base
  has_many :votes
  has_many :poll_choices, through: :votes
  
  normalize_attribute :phone_number, with: :phone
  
  validates :phone_number, presence: true, length: { in: 10..15 }
end
