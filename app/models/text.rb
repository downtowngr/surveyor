=begin

This class's main purpose is to bundle up information 
from a Twilio response, which represents a text message received
from someone who has been polled. 

Written by Conor Livingston, GR GiveCamp 2014
 
=end

class Text

  attr_reader :body, :from

  def initialize pollee_json_response
       
    response = "" 
    
    begin 
      repsonse = JSON.parse pollee_json_response
    rescue
      logger.error "There was an issue parsing the pollee's response in
      app/models/text.rb."
      
      raise JSON::ParserError
    end
    
    @from = response["from"]
    @body = response["body"]

  end

end
