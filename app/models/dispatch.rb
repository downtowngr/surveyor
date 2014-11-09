class Dispatch < ActiveRecord::Base
  belongs_to :poll

  validates :keyword, presence: true

  normalize_attribute :keyword, with: [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.upcase : value
  end

  def process_text(text)
    poll.strategy.constantize.process_text(poll, text)
  end
end

