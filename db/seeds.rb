unless Rails.env.production?
  User.destroy_all
  User.create(email: 'admin@downtowngr.org', password: 'password', password_confirmation: 'password')
end




                                                           
