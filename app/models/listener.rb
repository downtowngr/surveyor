class Listener < ActiveRecord::Base
  belongs_to :listening, polymorphic: true

  validates :keyword, presence: true

  normalize_attribute :keyword, with: [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.upcase : value
  end

  def trigger(text, citizen)
    listening.respond_to(text, citizen)
  end
end

