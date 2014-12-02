class Blast < ActiveRecord::Base
  has_and_belongs_to_many :citizens
  has_many :questions

  validates :message, presence: true, length: { maximum: 160 }
end
