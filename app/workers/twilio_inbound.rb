class TwilioInbound
  include Sidekiq::Worker

  def perform(twilio_params)
    @text = Text.new(twilio_params)
    @citizen = Citizen.find_or_create_by(phone_number: @text.number)

    unless @text.keyword
      @text.respond_with = "Sorry, I don't understand that. Try sending only one word."
      logger.info "Response contained unprocessable words"
    end

    # We have what looks like a valid keyword
    if @text.keyword?
      listener = Listener.find_by(keyword: @text.keyword)

      if listener.present?
        listener.trigger(@text, @citizen)
      else
        @text.respond_with = "Sorry, I don't know that option."
      end
    end

    TwilioSend.perform_async(@citizen.twilio_phone, @text.respond_with)
  end
end
