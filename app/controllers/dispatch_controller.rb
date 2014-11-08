class DispatchController < ApiController
  def trigger
    text = Text.new(twilio_params)
    response_word_list = text.body.split " "

    if response_word_list.size == 1
      keyword = response_word_list[0].downcase
      text.keyword = keyword
    elsif response_word_list.size > 1
      response_text = "Sorry, I don't understand that. Try sending only one word."
    else
      logger.info "Response contained no words."
    end

    listening_state = ListeningState.where(number: text.number) 
    

    unless response_text
      dispatch = Dispatch.find_by(keyword: keyword)
      if dispatch.present?
        response_text = dispatch.process_text(text)
      else
        response_text = "Sorry, I don't know that option."
      end
    end

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message response_text
    end

    render xml: twiml.text
  end

  private

  def twilio_params
    params.permit("Body", "From")
  end
end
