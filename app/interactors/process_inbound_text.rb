class ProcessInboundText
  include Interactor

  def call
    # listener = NumberListener.find_by(number: context.citizen.phone_number) ||
    #            KeywordListener.find_by(keyword: context.text.keyword)

    KeywordListener.respond_to(context.text, context.citizen)
  end
end
