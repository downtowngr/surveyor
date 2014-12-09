class SendBlastToList
  include Sidekiq::Worker

  def perform(blast_id)
    @blast = Blast.find(blast_id)

    @blast.citizens.each do |citizen|
      TwilioOutbound.perform_async(citizen.phone_number, @blast.message)
      @blast.send_question(citizen) if @blast.has_question?
    end
  end
end
