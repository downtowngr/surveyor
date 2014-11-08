class DispatchController < ApiController
  def trigger
    @text = Text.new(twilio_params)

    # listening_state = ListeningState.where(number: text.number) 
    # At this point we will eventually need to make a decision
    # about a path of action based on the listening_state of a
    # given citizen. 


    # For now the app will just assume that everything it receives
    # is a response to a poll question.
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
      dispatch = Dispatch.find_by(keyword: @text.keyword)
      if dispatch.present?
        @response_text = dispatch.process_text(@text)
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
