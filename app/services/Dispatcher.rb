=begin

This module contains logic to parse the body of text message 
reponses and dispatch further work to the appropriate controller 
based on matching keywords.

Written by Conor Livingston, GR GiveCamp 2014

=end

module Dispatcher

  module_function

  # This method should receive a JSON file that represents
  # the response of someone who has been polled and matches
  # keywords from their response with the contents of the
  # Dispatch table.
  # This method only attempts to match the first word from
  # the pollee's response. 
  # It then delegates further work to the appropriate
  # controller based on the controller that the keyword is
  # mapped to in the Dispatch table.
  def trigger response 
   
    # Text parses the JSON, and makes it accessible
    # in a nice clean Rubyist way. 
    text = Text.new response    

    response_word_list = text.body.split " "
    first_response_word = ""

    if response_word_list.size > 0 
      first_response_word = response_word_list[0].downcase
    else 
      logger.info "Response contained no words."
    end

    # Get actual list from Dispatch table here.
    keyword_to_klass_hash = Dispatch.keywords_to_klasses
  

    matched_word = ""

    keyword_to_klass_hash.each do |keyword, _|
      matched_word = first_response_word if first_response_word.eql?(keyword.downcase)
    end
   
    eval "#{keyword_to_klass_hash[matched_word]}.create(text)"
  end 

end
