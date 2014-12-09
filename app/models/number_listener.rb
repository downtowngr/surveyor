class NumberListener < ActiveRecord::Base
  belongs_to :listening, polymorphic: true

  validates :number, presence: true

  def respond_to(text, citizen)
    listening.respond_to(text, citizen)
  end
end
