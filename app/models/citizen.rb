class Citizen < ActiveRecord::Base
  normalize_attribute :phone_number, with: :phone
  
  validates :phone_number, presence: true, length: { is: 10 }
end
