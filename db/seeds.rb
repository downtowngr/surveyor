unless Rails.env.production?
  User.destroy_all
  User.create(email: 'admin@downtowngr.org', password: 'password', password_confirmation: 'password')

  Dispatch.destroy_all
  {Post: "PollChoiceController", dgri: "PollChoiceController"}.map do |k, v|
    Dispatch.create(keyword: k, klass: v)
  end

  ListeningState.destroy_all
  ListeningState.create(number: "1001001000", klass: "TextBlastController", event: "name")
  ListeningState.create(number: "2002002000", klass: "TextBlastController",
                  event: "phone_number")
  ListeningState.create(number: "3003003000", klass: "TextBlastController",
                  event: "address")
end




                                                           
