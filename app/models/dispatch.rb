class Dispatch < ActiveRecord::Base
  belongs_to :poll

  validates :keyword, presence: true

  normalize_attribute :keyword, with: [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.upcase : value
  end

  def trigger(text, citizen)
    poll.strategy.constantize.process_text(poll, text, citizen)
  end
end

