class Question < ActiveRecord::Base
  CITIZEN_ATTRIBUTES = {email: "email"}

  belongs_to :blast

  has_many :number_listeners, as: :listening, dependent: :destroy
  # Responsible for collecting answer, storing it

  def respond_to(text, citizen)
    citizen.send(citizen_attribute + "=", text.body)
    citizen.nationbuilder_tags = nationbuilder_tags

    citizen.save!
    citizen.sync_to_nationbuilder!

    destroy_listener(citizen)
    TwilioOutbound.perform_async(citizen.e164_phone, autoresponse)
  end

  def create_listener(citizen)
    number_listeners.create(number: citizen.phone_number)
  end

  def destroy_listener(citizen)
    number_listeners.find_by_number(citizen.phone_number).destroy!
  end
end
