class DispatchController < ApiController
  def trigger
    text = Text.new(twilio_params)
    response_word_list = text.body.split " "

    if response_word_list.size == 1
      keyword = response_word_list[0].downcase
    elsif response_word_list.size > 1
      response_text = "Sorry, I don't understand that. Try sending only one word."
    else
      logger.info "Response contained no words."
    end

    unless response_text
      dispatch = Dispatch.where(keyword: keyword)
      if dispatch.empty?
        response_text = "Sorry, I don't know that option."
      else
        response_text = eval("#{dispatch.klass}.create(text)")
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
