class Dispatch < ActiveRecord::Base
  # TODO: Dispatch needs to become Listener
  # TODO: Listener relationships need to be generic
  belongs_to :poll

  validates :keyword, presence: true

  normalize_attribute :keyword, with: [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.upcase : value
  end

  def trigger(text, citizen)
    poll.process_vote(text, citizen)
  end
end

