class Citizen < ActiveRecord::Base
  normalize_attribute :phone_number, with: :phone
  
  validates :phone_number, presence: true, length: { in: 10..15 }
end
