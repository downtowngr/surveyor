class TwilioInbound
  include Sidekiq::Worker

  def perform(twilio_params)
    @text = Text.new(twilio_params)
    @citizen = Citizen.find_or_create_by(phone_number: @text.number)

    ProcessInboundText.call(text: @text, citizen: @citizen)
    TwilioOutbound.perform_async(@citizen.e164_phone, @text.respond_with)
  end
end
