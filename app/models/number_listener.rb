class NumberListener < ActiveRecord::Base
  belongs_to :listening, polymorphic: true

  validates :number, presence: true

  def self.respond_to(text, citizen)

  end
end
