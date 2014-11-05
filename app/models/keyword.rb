class Keyword < ActiveRecord::Base
  # keyword can be a maximum of 20 characters, cannot have spaces, can begin
  # with a hashtag or an alphanumeric character
  validates :string, length: {minimum: 3, maximum: 20}, presence: true,
    format: { with: /^[[[:alnum:]]|#][\w|-]+$/i, on: :create }
end
