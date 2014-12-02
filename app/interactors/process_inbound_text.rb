class ProcessInboundText
  include Interactor

  def call
    # listener = NumberListener.find_by(number: context.citizen.phone_number) ||
    #            KeywordListener.find_by(keyword: context.text.keyword)

    # listener = Listener.find_by(keyword: context.text.keyword)

    unless context.text.keyword
      context.text.respond_with = "Sorry, I don't understand that. Try sending only one word."
    end

    # We have what looks like a valid keyword
    if context.text.keyword?
      listener = Listener.find_by(keyword: context.text.keyword)

      if listener.present?
        listener.trigger(context.text, context.citizen)
      else
        context.text.respond_with = "Sorry, I don't know that option."
      end
    end
  end
end
