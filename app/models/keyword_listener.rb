class KeywordListener < ActiveRecord::Base
  belongs_to :listening, polymorphic: true

  validates :keyword, presence: true

  normalize_attribute :keyword, with: [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.upcase : value
  end

  def respond_to(text, citizen)
    listening.respond_to(text, citizen)
  end

  def self.find_by_text(text)
    text.keyword = text.body.upcase if text.body =~ /^[[[:alnum:]]|#][\w|-]+$/

    if text.keyword?
      listener = find_by(keyword: text.keyword)

      if listener.present?
        listener
      else
        text.respond_with = "Sorry, I don't know that option."
      end
    else
      text.respond_with = "Sorry, I don't understand that."
    end
  end

  def self.respond_to(text, citizen)
    text.keyword = text.body.upcase if text.body =~ /^[[[:alnum:]]|#][\w|-]+$/

    if text.keyword?
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

