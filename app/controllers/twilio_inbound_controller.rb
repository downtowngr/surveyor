class TwilioInboundController < ApiController
  http_basic_authenticate_with name: Figaro.env.inbound_name,
                               password: Figaro.env.inbound_pass

  def create
    TwilioInbound.perform_async(twilio_params)

    render status: 200, xml: Twilio::TwiML::Response.new.text
  end

  private

  def twilio_params
    params.permit("Body", "From")
  end
end
