Twilio.configure do |config|
  config.account_sid = Figaro.env.twilio_account_sid
  config.auth_token =  Figaro.env.twilio_auth_token
end

$twilio = Twilio::REST::Client.new
