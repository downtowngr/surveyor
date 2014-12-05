class Blast < ActiveRecord::Base
  belongs_to :list
  has_many :questions

  def citizens
    list.citizens
  end

  validates :list_id, presence: true
  validates :message, presence: true, length: { maximum: 160 }
end
