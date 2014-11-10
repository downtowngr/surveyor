class PollChoice < ActiveRecord::Base
  belongs_to :poll
  has_many :votes, dependent: :destroy
  has_many :citizens, through: :votes

  normalize_attribute :name, with: [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.upcase : value
  end

  after_create do
    poll.listeners.create(keyword: name)
  end
end
