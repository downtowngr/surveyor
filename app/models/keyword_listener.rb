class KeywordListener < ActiveRecord::Base
  belongs_to :listening, polymorphic: true

  validates :keyword, presence: true

  normalize_attribute :keyword, with: [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.upcase : value
  end

  def self.respond_to(text, citizen)
    text.keyword = text.body.upcase if text.body =~ /^[[[:alnum:]]|#][\w|-]+$/

    if text.keyword.present?
      listener = find_by(keyword: text.keyword)

      if listener.present?
        listener.listening.respond_to(text, citizen)
      else
        text.respond_with = "Sorry, I don't know that option."
      end
    else
      text.respond_with = "Sorry, I don't understand that."
    end
  end
end

