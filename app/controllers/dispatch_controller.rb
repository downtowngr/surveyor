class DispatchController < ApiController
  def trigger
    response_text = Dispatcher.trigger(twilio_params)

    xml = Twilio::TwiML::Response.new do |r|
      r.Message response_text
    end

    render xml: response.text
  end

  private

  def twilio_params
    params.permit("Body", "From")
  end
end
