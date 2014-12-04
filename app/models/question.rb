class Question < ActiveRecord::Base
  belongs_to :blast
  has_one :number_listener, as: :listening, dependent: :destroy


end
