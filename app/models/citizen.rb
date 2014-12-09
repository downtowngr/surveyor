class Citizen < ActiveRecord::Base
  has_many :votes
  has_many :poll_choices, through: :votes
  has_many :check_ins
  has_many :listed_citizens
  has_many :lists, through: :listed_citizens

  validates :phone_number, presence: true, uniqueness: true, length: { is: 11 }

  attr_accessor :nationbuilder_tags

  def localized_phone
    PhoneNumber.new(phone_number).localized
  end

  def e164_phone
    PhoneNumber.new(phone_number).e164
  end

  def current_votes(poll)
    poll_choices.where(poll: poll)
  end

  def sync_to_nationbuilder!
    response = $nb.call(:people, :push,
                         person: {
                           id: nationbuilder_id,
                           mobile: localized_phone,
                           email: email,
                           mobile_opt_in: mobile_opt_in
                         })

    update(nationbuilder_id: response["person"]["id"]) if nationbuilder_id.nil?
    add_tags!(nationbuilder_tags) if nationbuilder_tags.present?
  end

  def add_tags!(tags)
    tags.each do |tag|
      $nb.call(:people, :tag_person, id: nationbuilder_id, tagging: {"tag" => tag})
    end
  end

  def self.update_or_create_from_nationbuilder(person)
    phone_number = PhoneNumber.new(person["mobile"]).national

    citizen = find_by(nationbuilder_id: person["id"]) ||
              find_or_initialize_by(phone_number: phone_number)

    citizen.nationbuilder_id ||= person["id"]

    citizen.assign_attributes(
      phone_number: phone_number,
      email: person["email"],
      full_name: "#{person["first_name"]} #{person["last_name"]}".strip,
      mobile_opt_in: person["mobile_opt_in"]
    )

    citizen.save!
    citizen
  end
end
