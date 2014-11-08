class Dispatch < ActiveRecord::Base
  belongs_to :poll

  validates :keyword, presence: true

  def process_text(text)
    poll.strategy.constantize.process_text(poll, text)
  end
end

