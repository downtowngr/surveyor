class Event < ActiveRecord::Base
  has_many :check_ins
  has_many :listeners, as: :listening

  validates :name, presence: true
  validates :keyword, presence: true

  normalize_attribute :keyword, with: [:strip, :blank] do |value|
    value.present? && value.is_a?(String) ? value.upcase : value
  end

  after_create do
    listeners.create(keyword: keyword)
  end

  def autoresponse=(response)
    if response
      text_template = Liquid::Template.parse(response)

      # Currently supporting 'name' and 'keyword' liquid tags
      super(text_template.render({"name" => name, "keyword" => keyword}))
    end
  end

  def respond_to(text, citizen)
    if check_in = check_ins.find_by_id(citizen.id)
      text.respond_with = "I love your enthusiasm! You've already checked in to #{name}."
    else
      check_ins.create(citizen: citizen)
      text.respond_with = autoresponse
    end
  end
end