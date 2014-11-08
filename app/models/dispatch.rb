class Dispatch < ActiveRecord::Base
  belongs_to :poll

  validates :keyword, presence: true

  def process_text(text)
    Object.get_constant(poll.strategy).process_text(poll, text)
  end
end

