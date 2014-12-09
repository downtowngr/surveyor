class Blast < ActiveRecord::Base
  belongs_to :list
  has_many :questions

  validates :list_id, presence: true
  validates :message, presence: true, length: { maximum: 160 }

  def citizens
    list.citizens
  end

  def has_question?
    questions.first.present?
  end

  def send_question(citizen)
    # TODO: will eventually walk through question order
    questions.first.create_listener(citizen)
    TwilioOutbound.perform_async(citizen.e164_phone, questions.first.prompt)
  end
end
