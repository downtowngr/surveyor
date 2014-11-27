class TwilioOutbound
  include Sidekiq::Worker

  def perform(number, body)
    twilio = Twilio::REST::Client.new(Figaro.env.twilio_account_sid,
                                      Figaro.env.twilio_auth_token)

    twilio.messages.create(
      from: Figaro.env.twilio_number,
      to: number,
      body: body
    )
  end
end
