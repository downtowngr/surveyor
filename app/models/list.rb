class List < ActiveRecord::Base
  has_many :listed_citizens
  has_many :citizens, through: :listed_citizens

  validates :collected_from, presence: true

  before_save do
    name = "#{collected_from.capitalize}"
  end

  def self.create_from_nationbuilder_tag(tag)
    list = create(type: "nationbuilder tag", status: "importing")
    ImportCitizensByNationbuilderTag.perform_async(list.id, tag)
    list
  end

  # def self.create_from_event()
  # end

  # def self.create_from_poll()
  # end
end
