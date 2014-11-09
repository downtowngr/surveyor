class DispatchController < ApiController
  def trigger
    @text = Text.new(twilio_params)
    @citizen = Citizen.find_or_create_by(phone_number: @text.number)

    check_keyword
    process_keyword

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message @response_text
    end
    render xml: twiml.text
  end

  private

  def process_keyword
    # No need to do this if response_text is already set
    unless @response_text
      dispatch = Dispatch.find_by(keyword: @text.keyword.upcase)
      if dispatch.present?
        dispatch.trigger(@text, @citizen)
        @response_text = "Thank you for participating in the downtowngr.org survey!"
      else
        @response_text = "Sorry, I don't know that option."
      end
    end
  end

  def check_keyword
    unless @text.keyword
      @response_text = "Sorry, I don't understand that. Try sending only one word."
      logger.info "Response contained zero or multiple words."
    end
  end

  def twilio_params
    params.permit("Body", "From")
  end
end
