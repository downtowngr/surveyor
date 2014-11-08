=begin

This class's main purpose is to bundle up information
from a Twilio response, which represents a text message received
from someone who has been polled.

Written by Conor Livingston, GR GiveCamp 2014

=end

class Text
  attr_reader :body, :from

  def initialize(params)
    @from = params["From"]
    @body = params["Body"]
  end
end
