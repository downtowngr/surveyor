=begin

This class's main purpose is to bundle up information
from a Twilio response, which represents a text message received
from someone who has been polled.

Written by Conor Livingston, GR GiveCamp 2014

=end

class Text
  attr_reader :body, :from
  attr_accessor :keyword

  def initialize(params)
    @from = params["From"]
    @body = params["Body"]
  end

  def number
    from
  end

  def word_array
    body.split(" ")
  end

  # There will only be a keyword if the 
  # the word array is size one.
  def keyword
    word_array.size == 1 ? word_array.first.upcase : nil
  end
end
