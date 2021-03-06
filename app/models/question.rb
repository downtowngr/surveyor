class Question < ActiveRecord::Base
  belongs_to :blast
  has_many :number_listeners, as: :listening, dependent: :destroy

  validates :citizen_attribute, presence: true
  validates :autoresponse, presence: true

  def respond_to(text, citizen)
    citizen.send(citizen_attribute + "=", text.body)
    citizen.nationbuilder_tags = nationbuilder_tags

    if citizen.save
      citizen.sync_to_nationbuilder!
      destroy_listener(citizen)

      # TODO: Will need to ask blast for next question
      text.respond_with = autoresponse
    elsif citizen.errors.get(citizen_attribute.to_sym).present?
      text.respond_with = "Sorry, that doesn't look like an #{citizen_attribute}. Text STOP to end."
    end
  end

  def create_listener(citizen)
    number_listeners.create(number: citizen.phone_number)
  end

  def destroy_listener(citizen)
    number_listeners.find_by_number(citizen.phone_number).destroy!
  end
end
