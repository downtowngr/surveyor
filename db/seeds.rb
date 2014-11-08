unless Rails.env.production?
  User.destroy_all
  User.create(email: 'admin@downtowngr.org', password: 'password', password_confirmation: 'password')

  Dispatch.destroy_all
  {Post: "PollChoiceController", dgri: "PollChoiceController"}.map do |k, v|
    Dispatch.create(keyword: k, klass: v)
  end
end




                                                           
