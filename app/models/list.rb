class List < ActiveRecord::Base
  has_many :listed_citizens
  has_many :citizens, through: :listed_citizens

  validates :collected_from, presence: true

  after_save do
    update_column(:name, "#{collected_from.capitalize} - #{updated_at.to_s(:short)}")
  end

  def self.create_from_nationbuilder_tag(tag)
    list = create(collected_from: "nationbuilder", status: "importing")
    ImportCitizensByNationbuilderTag.perform_async(list.id, tag)
    list
  end

  # def self.create_from_event()
  # end

  # def self.create_from_poll()
  # end
end
